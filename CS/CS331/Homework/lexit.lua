-- lexit.lua
-- Kaleb Burris
-- Started: 2024-02-15
-- Updated: 2024-03-04

-- Modified based on lexer.lua: https://github.com/ggchappell/cs331-2024-01/blob/main/lexer.lua
--   Original author: Glenn G. Chappell

-- For CS 331 Spring 2024
-- Assignment 3 Exercise B

-- Usage:
--
--    program = "print a+b;"  -- program to lex
--    for lexstr, cat in lexit.lex(program) do
--        -- lexstr is the string form of a lexeme.
--        -- cat is a number representing the lexeme category.
--        --  It can be used as an index for array lexit.catnames.
--    end


-- *********************************************************************
-- Module Table Initialization
-- *********************************************************************


local lexit = {}  -- Our module; members are added below


-- *********************************************************************
-- Public Constants
-- *********************************************************************


-- Numeric constants representing lexeme categories
lexit.KEY    = 1
lexit.ID     = 2
lexit.NUMLIT = 3
lexit.STRLIT = 4
lexit.OP     = 5
lexit.PUNCT  = 6
lexit.MAL    = 7


-- catnames
-- Array of names of lexeme categories.
-- Human-readable strings. Indices are above numeric constants.
lexit.catnames = {
    "Keyword",
    "Identifier",
    "NumericLiteral",
    "StringLiteral",
    "Operator",
    "Punctuation",
    "Malformed"
}


-- *********************************************************************
-- Kind-of-Character Functions
-- *********************************************************************

-- All functions return false when given a string whose length is not
-- exactly 1.


-- isLetter
-- Returns true if string c is a letter character, false otherwise.
local function isLetter(c)
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
    if c:len() ~= 1 then
        return false
    elseif c == " " or c == "\t" or c == "\n" or c == "\r" or c == "\f" then
        return true
    else
        return false
    end
end


-- isPrintableASCII
-- Returns true if string c is a printable ASCII character (codes 32 " "
-- through 126 "~"), false otherwise.
local function isPrintableASCII(c)
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


-- *********************************************************************
-- The lexit
-- *********************************************************************


-- lex
-- Our lexit
-- Intended for use in a for-in loop:
--     for lexstr, cat in lexit.lex(program) do
-- Here, lexstr is the string form of a lexeme, and cat is a number
-- representing a lexeme category. (See Public Constants.)
function lexit.lex(program)
    -- ***** Variables (like class data members) *****

    local pos       -- Index of next character in program
                    -- INVARIANT: when getLexeme is called, pos is
                    --  EITHER the index of the first character of the
                    --  next lexeme OR program:len()+1
    local state     -- Current state for our state machine
    local ch        -- Current character
    local lexstr    -- The lexeme, so far
    local category  -- Category of lexeme, set when state set to DONE
    local handlers  -- Dispatch table; value created later
    local opener    -- Handles STRINGLITERAL opening values ("\"" or "\'")

    -- ***** States *****

    local DONE          = 0
    local START         = 1
    local LETTER        = 2
    local DIGIT         = 3
    local DIGDOT        = 4
    local DOT           = 5
    local EXPONENT      = 6
    local STRINGLITERAL = 7
    local OP            = 8

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
        return program:sub(pos+1, pos+1)
    end

    -- drop1
    -- Move pos to the next character.
    local function drop1()
        pos = pos+1
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
            drop1()  -- Drop leading "#"
            while true do
                if currChar() == "\n" or currChar() == "" then  -- End of input?
                    drop1()
                    break
                end
                drop1()  -- Drop character inside comment
            end
        end
    end

    -- ***** State-Handler Functions *****

    -- A function with a name like handle_XYZ is the handler function
    -- for state XYZ

    -- State DONE: lexeme is done; this handler should not be called.
    local function handle_DONE()
        error("'DONE' state should not be handled\n")
    end

    -- State START: no character read yet.
    local function handle_START()
        if isIllegal(ch) then
            add1()
            state = DONE
            category = lexit.MAL
        elseif isLetter(ch) or ch == "_" then
            add1()
            state = LETTER
        elseif isDigit(ch) then
            add1()
            state = DIGIT
        elseif ch == "." then
            add1()
            state = DOT
        elseif ch == "\"" or ch =="\'" then
            -- Store an opening string value
            opener = ch
            add1()
            state = STRINGLITERAL
        elseif ch == "=" or ch == "!" or ch == "<" or ch == "*" or ch == "/" or ch == "%"  
            or ch == "!" or ch == "[" or ch == "]" or ch == "+" or ch == "-" or ch == ">" then
            -- Don't add1() to allow for multiple char long operators
            state = OP
        else
            add1()
            state = DONE
            category = lexit.PUNCT
        end
    end

    -- State LETTER: we are in an ID.
    local function handle_LETTER()
        if isLetter(ch) or isDigit(ch) or ch == "_" then
            add1()
        else
            state = DONE
            if lexstr == "and" or lexstr == "char" or lexstr == "def" or lexstr == "else" or lexstr == "elseif"
              or lexstr == "eol" or lexstr == "true" or lexstr == "false" or lexstr == "if" or lexstr == "inputnum"
              or lexstr == "not" or lexstr == "or" or lexstr == "output" or lexstr == "rand" or lexstr == "return"
              or lexstr == "while" then
                category = lexit.KEY
            else
                category = lexit.ID
            end
        end
    end

    -- State DIGIT: we are in a NUMLIT, and we have NOT seen ".".
    local function handle_DIGIT()
        if isDigit(ch) then
            add1()
        elseif (ch == "e" or ch == "E") and state == DIGIT then
            state = EXPONENT
        else
            state = DONE
            category = lexit.NUMLIT
        end
    end
    
    -- State EXPONENT: we are in a NUMLIT, and we have seen "e" or "E".
    local function handle_EXPONENT()
        -- Handle "+" exponent case
        if nextChar() == "+" and isDigit(program:sub(pos+2,pos+2)) then
            add1()
            add1()
            ch = currChar()
        elseif isDigit(nextChar()) then
            add1()
            ch = currChar()
        else
            state = DONE
            category = lexit.NUMLIT
        end
          
        while true do
            if isDigit(ch) then
                add1()
                ch = currChar()
            else
                state = DONE
                category = lexit.NUMLIT
                return
            end
        end
    end

    -- State DIGDOT: we are in a NUMLIT, and we have seen ".".
    local function handle_DIGDOT()
        if isDigit(ch) then
            add1()
        else
            state = DONE
            category = lexit.PUNCT
        end
    end

    -- State DOT: we have seen a dot (".") and nothing else.
    local function handle_DOT()
        if isDigit(ch) and state == DIGDOT then
            add1()
            state = DIGDOT
        else
            state = DONE
            category = lexit.PUNCT
        end
    end
    
    -- State STRINGLITERAL: we have seen a "\"" or "\'".
    local function handle_STRINGLITERAL()
        if ch == opener then
            add1()
            state = DONE
            category = lexit.STRLIT
        elseif ch == "\n" or ch == "" then
            state = DONE
            category = lexit.MAL
        else
          add1()
        end
    end
    
    -- State OP: we have seen any of the operator symbols:
    -- ==   !=   <   <=   >   >=   +   -   *   /   %   [  ]  =
    local function handle_OP()
        if nextChar() == "=" then
            if not (currChar() == "=" or currChar() == "<" or 
                    currChar() == ">" or currChar() == "!") then
              add1()
              state = DONE
              category = lexit.OP
              return
            end
            add1()
        elseif currChar() == "!" then
            add1()
            state = DONE
            category = lexit.PUNCT
            return
        end
        add1()
        state = DONE
        category = lexit.OP
    end

    -- ***** Table of State-Handler Functions *****

    handlers = {
        [DONE]=handle_DONE,
        [START]=handle_START,
        [LETTER]=handle_LETTER,
        [DIGIT]=handle_DIGIT,
        [DIGDOT]=handle_DIGDOT,
        [DOT]=handle_DOT,
        [EXPONENT]=handle_EXPONENT,
        [STRINGLITERAL]=handle_STRINGLITERAL,
        [OP]=handle_OP,
    }

    -- ***** Iterator Function *****

    -- getLexeme
    -- Called each time through the for-in loop.
    -- Returns a pair: lexeme-string (string) and category (int), or
    -- nil, nil if no more lexemes.
    local function getLexeme()
        if pos > program:len() then
            return nil, nil
        end
        lexstr = ""
        state = START
        while state ~= DONE do
            ch = currChar()
            handlers[state]()
        end

        skipToNextLexeme()
        return lexstr, category
    end

    -- ***** Body of Function lex *****

    -- Initialize & return the iterator function
    pos = 1
    skipToNextLexeme()
    return getLexeme
end


-- *********************************************************************
-- Module Table Return
-- *********************************************************************


return lexit
