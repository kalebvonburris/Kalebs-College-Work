-- lexit.lua
-- Kaleb Burris
-- 2026-02-13
--
-- Exercise A answer:
--
-- "HAPPINESS IS A WARM PUPPY."
--
-- Assignment 3: Writing a Lexer
-- Exercise B - Lexer in Lua
-- Code modified from lexer.lua from
-- Glenn G. Chappell's CS331 Course:
-- https://github.com/ggchappell/cs331-2026-01/blob/b369b5484bb800eeaef17aea6dbba650edc9d338/lexer.lua

-- *********************************************************************
-- Module Table Initialization
-- *********************************************************************


local lexer = {} -- Our module; members are added below


-- *********************************************************************
-- Public Constants
-- *********************************************************************


-- Numeric constants representing lexeme categories
lexer.KEY    = 1
lexer.ID     = 2
lexer.NUMLIT = 3
lexer.STRLIT = 4
lexer.OP     = 5
lexer.PUNCT  = 6
lexer.MAL    = 7


-- catnames
-- Array of names of lexeme categories.
-- Human-readable strings. Indices are above numeric constants.
lexer.catnames = {
  "Keyword",
  "Identifier",
  "NumericLiteral",
  "StringLiteral",
  "Operator",
  "Punctuation",
  "Malformed"
}

-- keywords
-- Array of reserved keywords.
local keywords = {
  "chr", "else", "elsif", "func", "if", "print",
  "println", "readint", "return", "rnd", "while"
}

-- operators
-- All possible complete operators.
local operators = {
  "+", "-", "*", "/", "=", "==", "!=", "<", "<=", ">", ">=",
  "!", "&&", "||", "]", "[", "++", "--", "%"
}

-- op starters
-- All possible first characters of operators. Used to decide when to enter OP state.
-- Not all of these are operators!
local op_starters = {
  "+", "-", "*", "/", "=", "!", "<", ">",
  "&", "|", "]", "[", "%"
}

-- *********************************************************************
-- Kind-of-Character Functions
-- *********************************************************************


-- isLetter
-- Returns true if string c is a letter character, false otherwise.
local function isLetter(c)
  assert(type(c) == "string")
  if c:len() ~= 1 then
    return false
  elseif c >= "A" and c <= "Z" then
    return true
  elseif c >= "a" and c <= "z" then
    return true
  else
    return false
  end
end


-- isDigit
-- Returns true if string c is a digit character, false otherwise.
local function isDigit(c)
  assert(type(c) == "string")
  if c:len() ~= 1 then
    return false
  elseif c >= "0" and c <= "9" then
    return true
  else
    return false
  end
end


-- isWhitespace
-- Returns true if string c is a whitespace character, false otherwise.
local function isWhitespace(c)
  assert(type(c) == "string")
  if c:len() ~= 1 then
    return false
  elseif c == " " or c == "\t" or c == "\n" or c == "\r"
      or c == "\f" then
    return true
  else
    return false
  end
end


-- isPrintableASCII
-- Returns true if string c is a printable ASCII character (codes 32 " "
-- through 126 "~"), false otherwise.
local function isPrintableASCII(c)
  assert(type(c) == "string")
  if c:len() ~= 1 then
    return false
  elseif c >= " " and c <= "~" then
    return true
  else
    return false
  end
end


-- isIllegal
-- Returns true if string c is an illegal character, false otherwise.
local function isIllegal(c)
  assert(type(c) == "string")
  if c:len() ~= 1 then
    return false
  elseif isWhitespace(c) then
    return false
  elseif isPrintableASCII(c) then
    return false
  else
    return true
  end
end


-- isInTable
-- Returns true if string s is an element of table t, false otherwise.
local function isInTable(s, t)
  for _, v in ipairs(t) do
    if s == v then
      return true
    end
  end
  return false
end


-- *********************************************************************
-- The Lexer
-- *********************************************************************


-- lex
-- Our lexer
-- Intended for use in a for-in loop:
--     for lexstr, cat in lexer.lex(program) do
-- Here, lexstr is the string form of a lexeme, and cat is a number
-- representing a lexeme category. (See Public Constants.)
function lexer.lex(program)
  -- ***** Variables (like class data members) *****

  local pos -- Index of next character in program
  -- INVARIANT: when getLexeme is called, pos is
  --  EITHER the index of the first character of the
  --  next lexeme OR program:len()+1
  local state    -- Current state for our state machine
  local ch       -- Current character
  local lexstr   -- The lexeme, so far
  local category -- Category of lexeme, set when state is set to DONE
  local handlers -- Dispatch table; value created later

  -- ***** States *****

  local DONE   = 0
  local START  = 1
  local LETTER = 2
  local NUMBER = 3
  local SCINOT = 4
  local OP     = 5
  local STRLIT = 6

  -- ***** Character-Related Utility Functions *****

  -- currChar
  -- Return the current character, at index pos in program. Return
  -- value is a single-character string, or the empty string if pos is
  -- past the end.
  local function currChar()
    return program:sub(pos, pos)
  end

  -- nextChar
  -- Return the next character, at index pos+1 in program. Return
  -- value is a single-character string, or the empty string if pos+1
  -- is past the end.
  local function nextChar()
    return program:sub(pos + 1, pos + 1)
  end

  -- drop1
  -- Move pos to the next character.
  local function drop1()
    pos = pos + 1
  end

  -- add1
  -- Add the current character to the lexeme, moving pos to the next
  -- character.
  local function add1()
    lexstr = lexstr .. currChar()
    drop1()
  end

  -- skipToNextLexeme
  -- Skip whitespace and comments, moving pos to the beginning of
  -- the next lexeme, or to program:len()+1.
  local function skipToNextLexeme()
    while true do
      -- Skip whitespace characters
      while isWhitespace(currChar()) do
        drop1()
      end

      -- Done if no comment
      if currChar() ~= "#" then
        break
      end

      -- Skip comment
      drop1() -- Drop the "#"
      while true do
        -- End comments at newlines or end of program
        if currChar() == "\n" or currChar() == "" then
          drop1() -- Drop the newline, if there is one
          break   -- Break out of comment loop, continue until next lexeme is found
        end
        drop1()   -- Drop character inside comment
      end

      -- Break on end of program, otherwise continue to skip whitespace and comments
      if currChar() == "" then
        drop1() -- Move pos to program:len()+1
        break
      end
    end
  end

  -- ***** State-Handler Functions *****

  -- A function with a name like handle_XYZ is the handler function
  -- for state XYZ

  -- State DONE: lexeme is done; this handler must not be called.
  local function handle_DONE()
    error("'DONE' state must not be handled\n")
  end

  -- State START: no character read yet.
  local function handle_START()
    if isIllegal(ch) then
      add1()
      state = DONE
      category = lexer.MAL
    elseif isLetter(ch) or ch == "_" then
      add1()
      state = LETTER
    elseif isDigit(ch) then
      add1()
      state = NUMBER
    elseif isInTable(ch, op_starters) then
      add1()
      state = OP
    elseif ch == "'" or ch == '"' then
      add1()
      state = STRLIT
    else
      add1()
      state = DONE
      category = lexer.PUNCT
    end
  end

  -- State LETTER: we are in an ID or KEYWORD.
  local function handle_LETTER()
    if isLetter(ch) or ch == "_" or isDigit(ch) then
      add1()
    else
      state = DONE
      if isInTable(lexstr, keywords) then
        category = lexer.KEY
      else
        category = lexer.ID
      end
    end
  end

  -- State NUMBER: we are in a NUMLIT
  local function handle_NUMBER()
    if isDigit(ch) then
      add1()
    elseif ch == "e" or ch == "E" then
      -- If we see a plus, it MUST be followed by a digit!
      if nextChar() == "+" then
        -- Look-a-head for the required digit after the '+'
        if isDigit(program:sub(pos + 2, pos + 2)) then
          add1() -- Add the 'e' or 'E'
          add1() -- Add the '+'
          add1() -- Add the digit after the '+'
          state = SCINOT
          return
        else
          -- Not scientific notation, just a number followed by 'e' or 'E'
          state = DONE
          category = lexer.NUMLIT
          return
        end
      elseif isDigit(nextChar()) then
        -- There is no '+' in the scientific notation, just an 'e' or 'E' followed by a digit
        add1()
        state = SCINOT
      else
        -- We have a number followed by an 'e' or 'E', but it's not scientific notation, since there is no digit after the 'e' or 'E'
        state = DONE
        category = lexer.NUMLIT
      end
    else
      state = DONE
      category = lexer.NUMLIT
    end
  end

  -- State SCINOT: we are in the exponent part of a NUMLIT
  -- '+' state is already handled in NUMBER state, so we only need to handle digits here
  local function handle_SCINOT()
    if isDigit(ch) then
      add1()
    else
      state = DONE
      category = lexer.NUMLIT
    end
  end

  -- State OP: we have seen an operator start character, and may be in a longer operator.
  local function handle_OP()
    -- Check if the operator is compound first (eg. "++", "+=", "&&")
    if isInTable(lexstr .. ch, operators) then
      add1()
      category = lexer.OP
    elseif isInTable(lexstr, operators) then
      category = lexer.OP
    else
      -- If the char isn't an operator, then it is just a single char punct lexeme (eg. "&", "|")
      category = lexer.PUNCT
    end
    state = DONE
  end

  -- State STRLIT: we are in a string literal, and the first quote has been read.
  local function handle_STRLIT()
    -- Loop until we see the matching closing quote
    if ch == lexstr:sub(1, 1) then
      state = DONE
      category = lexer.STRLIT
    elseif ch == "" or ch == "\n" then
      -- Unterminated string literal
      state = DONE
      category = lexer.MAL
      return
    end
    add1()
  end

  -- ***** Table of State-Handler Functions *****

  handlers = {
    [DONE] = handle_DONE,
    [START] = handle_START,
    [LETTER] = handle_LETTER,
    [NUMBER] = handle_NUMBER,
    [SCINOT] = handle_SCINOT,
    [OP] = handle_OP,
    [STRLIT] = handle_STRLIT,
  }

  -- ***** Body of Function lex *****

  assert(type(program) == "string")

  -- Make a coroutine, and return wrapper function as iterator
  return coroutine.wrap(function()
    pos = 1 -- Start at the beginning
    while true do
      -- Move to next lexeme, if any, and see if we're done
      skipToNextLexeme()
      if pos > program:len() then
        return nil, nil
      end

      -- There is another lexeme; init vars and run state machine
      lexstr = ""
      state = START
      while state ~= DONE do
        ch = currChar()
        --print('In state: ' .. state .. ' with char \"' .. ch .. '\"')
        handlers[state]()
      end

      -- Spit out the lexeme, then do it all again
      coroutine.yield(lexstr, category)
    end
  end)
end

-- *********************************************************************
-- Module Table Return
-- *********************************************************************


return lexer
