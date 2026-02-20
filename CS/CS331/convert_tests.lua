#!/usr/bin/env lua
--- convert_tests.lua
--- Reads lexit_test.lua and outputs equivalent Rust #[test] functions to stdout.
--- Usage: lua convert_tests.lua lexit_test.lua > lexer_tests.rs

-- ──────────────────────────────────────────────
-- Configuration
-- ──────────────────────────────────────────────

--- Lua category number → Rust enum variant.
local CAT_RUST = {
  [1] = "Lexeme::Keyword",
  [2] = "Lexeme::Identifier",
  [3] = "Lexeme::NumericLiteral",
  [4] = "Lexeme::StringLiteral",
  [5] = "Lexeme::Operator",
  [6] = "Lexeme::Punctuation",
  [7] = "Lexeme::Malformed(LexingError::NonLegalChar)",
}

-- ──────────────────────────────────────────────
-- Utility
-- ──────────────────────────────────────────────

--- Escape a raw string for use inside a Rust double-quoted literal.
local function rust_escape(s)
  local out = {}
  for i = 1, #s do
    local b = s:byte(i)
    if b == 0x5C then
      out[#out + 1] = "\\\\"
    elseif b == 0x22 then
      out[#out + 1] = '\\"'
    elseif b == 0x0A then
      out[#out + 1] = "\\n"
    elseif b == 0x0D then
      out[#out + 1] = "\\r"
    elseif b == 0x09 then
      out[#out + 1] = "\\t"
    elseif b < 0x20 or b > 0x7E then
      out[#out + 1] = string.format("\\x%02x", b)
    else
      out[#out + 1] = string.char(b)
    end
  end
  return table.concat(out)
end

--- Sanitize a test name into a valid Rust identifier.
local function sanitize(name)
  name = name:lower()
  name = name:gsub("[^a-z0-9]+", "_")
  name = name:gsub("^_+", ""):gsub("_+$", "")
  if name:match("^%d") then name = "n_" .. name end
  if name == "" then name = "unnamed" end
  local kw = {
    ["type"] = 1,
    ["return"] = 1,
    ["if"] = 1,
    ["else"] = 1,
    ["while"] = 1,
    ["loop"] = 1,
    ["match"] = 1,
    ["mod"] = 1,
    ["fn"] = 1,
    ["use"] = 1,
    ["self"] = 1,
    ["ref"] = 1,
  }
  if kw[name] then name = name .. "_kw" end
  return name
end

-- ──────────────────────────────────────────────
-- Load the test file without running tests
-- ──────────────────────────────────────────────

local input_file = arg[1] or "lexit_test.lua"

-- Prevent os.exit from killing us
os.exit = function() end

-- Provide a stub lexit module
package.loaded["lexit"] = {
  KEY = 1,
  ID = 2,
  NUMLIT = 3,
  STRLIT = 4,
  OP = 5,
  PUNCT = 6,
  MAL = 7,
  catnames = {
    "Keyword", "Identifier", "NumericLiteral", "StringLiteral",
    "Operator", "Punctuation", "Malformed",
  },
  lex = function() return function() end end,
}

-- Read file and strip the bottom-of-file execution lines
-- so we only get function/variable definitions.
local f = io.open(input_file, "r")
if not f then
  io.stderr:write("Error: cannot open " .. input_file .. "\n")
  return
end
local source = f:read("*a")
f:close()

-- Remove trailing calls: test_lexit(...), endMessage(...), terminate(...)
source = source:gsub("test_lexit%s*%b()", "")
source = source:gsub("endMessage%s*%b()", "")
source = source:gsub("terminate%s*%b()", "")

-- Execute to define all globals (tester, checkLex, test_*, etc.)
local chunk, err = load(source, input_file)
if not chunk then
  io.stderr:write("Error loading: " .. tostring(err) .. "\n")
  return
end
chunk()

-- ──────────────────────────────────────────────
-- Install our interceptor and run the suites
-- ──────────────────────────────────────────────

local collected = {}
local current_suite = "misc"

-- Override checkLex to capture tests instead of running the lexer
checkLex = function(t, prog, expectedOutput, testName)
  local pairs = {}
  for i = 1, #expectedOutput, 2 do
    pairs[#pairs + 1] = { expectedOutput[i], expectedOutput[i + 1] }
  end
  collected[#collected + 1] = {
    input    = prog,
    expected = pairs,
    name     = testName or "unnamed",
    suite    = current_suite,
  }
end

-- Detect suite names from io.write calls inside suite functions
local real_io_write = io.write
io.write = function(s)
  if type(s) == "string" then
    local suite = s:match("Test Suite:%s*(.*)")
    if suite then
      current_suite = sanitize(suite:gsub("%s+$", ""))
    end
  end
end

-- Call each suite function (these are globals defined by the test file)
local suite_funcs = {
  "test_export", "test_idkey", "test_numlit", "test_strlit",
  "test_op", "test_illegal", "test_comment", "test_program",
}
for _, name in ipairs(suite_funcs) do
  local fn = _G[name]
  if fn then
    fn(tester)
  else
    io.stderr:write("Warning: " .. name .. " not found, skipping\n")
  end
end

io.write = real_io_write

-- ──────────────────────────────────────────────
-- Emit Rust test code
-- ──────────────────────────────────────────────

local out = {}
local function emit(s) out[#out + 1] = s end

emit("#[cfg(test)]")
emit("mod tests {")
emit("    use super::*;")
emit("")
emit("    /// Lex input and collect all (Lexeme, String) pairs.")
emit("    fn lex_all(input: &str) -> Vec<(Lexeme, String)> {")
emit("        let mut lexer = Lexer::new(input.to_string());")
emit("        lexer.lex_input()")
emit("    }")
emit("")
emit("    /// Returns `true` if two lexemes match, treating all `Malformed` variants as equal.")
emit("    fn lexeme_eq(a: &Lexeme, b: &Lexeme) -> bool {")
emit("        match (a, b) {")
emit("            (Lexeme::Malformed(_), Lexeme::Malformed(_)) => true,")
emit("            _ => a == b,")
emit("        }")
emit("    }")
emit("")
emit("    /// Assert that lexing `input` produces the expected (category, text) pairs.")
emit("    /// All `Malformed` variants are treated as equivalent regardless of inner error.")
emit("    fn check_lex(input: &str, expected: &[(Lexeme, &str)]) {")
emit("        let actual = lex_all(input);")
emit("        assert_eq!(")
emit("            actual.len(), expected.len(),")
emit('            "\\nInput: {:?}\\nExpected {} lexemes, got {}\\nActual: {:?}",')
emit("            input, expected.len(), actual.len(), actual")
emit("        );")
emit("        for (i, ((a_cat, a_str), (e_cat, e_str))) in actual.iter().zip(expected.iter()).enumerate() {")
emit("            assert!(")
emit("                lexeme_eq(a_cat, e_cat) && a_str == e_str,")
emit('                "\\nInput: {:?}\\nMismatch at token {}:\\n  expected: ({:?}, {:?})\\n  actual:   ({:?}, {:?})",')
emit("                input, i, e_cat, e_str, a_cat, a_str")
emit("            );")
emit("        }")
emit("    }")
emit("")

-- Group by suite, preserving insertion order
local suites = {}
local suite_tests = {}
local used_names = {}

for _, t in ipairs(collected) do
  local s = t.suite
  if not suite_tests[s] then
    suites[#suites + 1] = s
    suite_tests[s] = {}
    used_names[s] = {}
  end
  suite_tests[s][#suite_tests[s] + 1] = t
end

for _, suite in ipairs(suites) do
  emit("    mod " .. suite .. " {")
  emit("        use super::*;")
  emit("")

  for _, t in ipairs(suite_tests[suite]) do
    local base = sanitize(t.name)
    local name = base
    local ctr = 2
    while used_names[suite][name] do
      name = base .. "_" .. ctr
      ctr = ctr + 1
    end
    used_names[suite][name] = true

    local input_rust = '"' .. rust_escape(t.input) .. '"'

    local pair_strs = {}
    for _, p in ipairs(t.expected) do
      local cat_rust = CAT_RUST[p[2]]
          or ("/* UNKNOWN:" .. tostring(p[2]) .. " */")
      pair_strs[#pair_strs + 1] = "("
          .. cat_rust .. ', "' .. rust_escape(p[1]) .. '")'
    end

    emit("        #[test]")
    emit("        fn " .. name .. "() {")

    if #pair_strs == 0 then
      emit("            check_lex(" .. input_rust .. ", &[]);")
    elseif #pair_strs <= 3 then
      emit("            check_lex(" .. input_rust .. ", &["
        .. table.concat(pair_strs, ", ") .. "]);")
    else
      emit("            check_lex(" .. input_rust .. ", &[")
      for _, ps in ipairs(pair_strs) do
        emit("                " .. ps .. ",")
      end
      emit("            ]);")
    end

    emit("        }")
    emit("")
  end

  emit("    }")
  emit("")
end

emit("}")

print(table.concat(out, "\n"))

io.stderr:write(string.format("Converted %d tests across %d suites\n",
  #collected, #suites))
rint(string.format("Converted %d tests across %d suites\n", #collected, #suites))
