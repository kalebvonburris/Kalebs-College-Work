checkLex(t, "a", { "a", IDx }, "letter")
checkLex(t, " a", { "a", IDx }, "space + letter")
checkLex(t, "_", { "_", IDx }, "underscore")
checkLex(t, " _", { "_", IDx }, "space + underscore")
checkLex(t, "bx", { "bx", IDx }, "letter + letter")
checkLex(t, "b3", { "b3", IDx }, "letter + digit")
checkLex(t, "_n", { "_n", IDx }, "underscore + letter")
checkLex(t, "_4", { "_4", IDx }, "underscore + digit")
checkLex(t, "abc_39xyz", { "abc_39xyz", IDx },
  "medium-length Identifier")
checkLex(t, "abc eol_3", { "abc", IDx, "eol_3", IDx },
  "Identifier + Identifier")
checkLex(t, "a  ", { "a", IDx }, "single letter + space")
checkLex(t, "a#", { "a", IDx }, "single letter + comment")
checkLex(t, "a #", { "a", IDx }, "single letter + space + comment")
checkLex(t, " a", { "a", IDx }, "space + letter")
checkLex(t, "#\na", { "a", IDx }, "comment + letter")
checkLex(t, "#\n a", { "a", IDx }, "comment + space + letter")
checkLex(t, "ab", { "ab", IDx }, "two letters")
checkLex(t, "chr", { "chr", KEYx }, "keyword: char")
checkLex(t, "else", { "else", KEYx }, "keyword: else")
checkLex(t, "elsif", { "elsif", KEYx }, "keyword: elsif")
checkLex(t, "func", { "func", KEYx }, "keyword: func")
checkLex(t, "if", { "if", KEYx }, "keyword: if")
checkLex(t, "print", { "print", KEYx }, "keyword: print")
checkLex(t, "println", { "println", KEYx }, "keyword: println")
checkLex(t, "readint", { "readint", KEYx }, "keyword: readint")
checkLex(t, "return", { "return", KEYx }, "keyword: return")
checkLex(t, "rnd", { "rnd", KEYx }, "keyword: rnd")
checkLex(t, "while", { "while", KEYx }, "keyword: while")
checkLex(t, "funcc", { "funcc", IDx }, "keyword+letter")
checkLex(t, "chr2", { "chr2", IDx }, "keyword+digit")
checkLex(t, "Print", { "Print", IDx }, "keyword -> first letter UC")
checkLex(t, "elsE", { "elsE", IDx }, "keyword -> last letter UC")
checkLex(t, "IF", { "IF", IDx }, "keyword -> all UC")
checkLex(t, "elsi", { "elsi", IDx }, "partial keyword #1")
checkLex(t, "printl", { "printl", IDx }, "partial keyword #2")
checkLex(t, "els if", { "els", IDx, "if", KEYx }, "split keyword #1")
checkLex(t, "re#\nturn", { "re", IDx, "turn", IDx }, "split keyword #2")
checkLex(t, "whi2le", { "whi2le", IDx }, "split keyword #3")
checkLex(t, "pri_nt", { "pri_nt", IDx }, "split keyword #4")
checkLex(t, "_chr", { "_chr", IDx }, "_ + keyword")
checkLex(t, "ifreturn", { "ifreturn", IDx }, "keyword + keyword")
checkLex(t, "3", { "3", NUMLITx }, "single digit")
checkLex(t, "3a", { "3", NUMLITx, "a", IDx }, "single digit then letter")

checkLex(t, "123456", { "123456", NUMLITx }, "num, no dot")
checkLex(t, ".123456", { ".", PUNCTx, "123456", NUMLITx },
  "num, dot @ start")
checkLex(t, "123456.", { "123456", NUMLITx, ".", PUNCTx },
  "num, dot @ end")
checkLex(t, "123.456", { "123", NUMLITx, ".", PUNCTx, "456", NUMLITx },
  "num, dot in middle")
checkLex(t, "1.2.3", { "1", NUMLITx, ".", PUNCTx, "2", NUMLITx, ".", PUNCTx,
  "3", NUMLITx }, "num, 2 dots")

checkLex(t, "+123456", { "+", OPx, "123456", NUMLITx }, "+num, no dot")
checkLex(t, "+.123456", { "+", OPx, ".", PUNCTx, "123456", NUMLITx },
  "+num, dot @ start")
checkLex(t, "+123456.", { "+", OPx, "123456", NUMLITx, ".", PUNCTx },
  "+num, dot @ end")
checkLex(t, "+123.456", { "+", OPx, "123", NUMLITx, ".", PUNCTx,
    "456", NUMLITx },
  "+num, dot in middle")
checkLex(t, "+1.2.3", { "+", OPx, "1", NUMLITx, ".", PUNCTx, "2", NUMLITx,
  ".", PUNCTx, "3", NUMLITx }, "+num, 2 dots")

checkLex(t, "-123456", { "-", OPx, "123456", NUMLITx }, "-num, no dot")
checkLex(t, "-.123456", { "-", OPx, ".", PUNCTx, "123456", NUMLITx },
  "-num, dot @ start")
checkLex(t, "-123456.", { "-", OPx, "123456", NUMLITx, ".", PUNCTx },
  "-num, dot @ end")
checkLex(t, "-123.456", { "-", OPx, "123", NUMLITx, ".", PUNCTx,
    "456", NUMLITx },
  "-num, dot in middle")
checkLex(t, "-1.2.3", { "-", OPx, "1", NUMLITx, ".", PUNCTx, "2", NUMLITx,
  ".", PUNCTx, "3", NUMLITx }, "-num, 2 dots")

checkLex(t, "+-123456", { "+", OPx, "-", OPx, "123456", NUMLITx },
  "+-num, no dot")
checkLex(t, "-+123456", { "-", OPx, "+", OPx, "123456", NUMLITx },
  "++num, dot @ end")

checkLex(t, "123 456", { "123", NUMLITx, "456", NUMLITx },
  "space-separated nums")

-- Exponents
checkLex(t, "123e456", { "123e456", NUMLITx }, "num with exp")
checkLex(t, "123e+456", { "123e+456", NUMLITx }, "num with +exp")
checkLex(t, "123e-456", { "123", NUMLITx, "e", IDx, "-", OPx,
  "456", NUMLITx }, "num with -exp")
checkLex(t, "+123e456", { "+", OPx, "123e456", NUMLITx },
  "+num with exp")
checkLex(t, "+123e+456", { "+", OPx, "123e+456", NUMLITx },
  "+num with +exp")
checkLex(t, "+123e-456", { "+", OPx, "123", NUMLITx, "e", IDx, "-", OPx,
    "456", NUMLITx },
  "+num with -exp")
checkLex(t, "-123e456", { "-", OPx, "123e456", NUMLITx },
  "-num with exp")
checkLex(t, "-123e+456", { "-", OPx, "123e+456", NUMLITx },
  "-num with +exp")
checkLex(t, "-123e-456", { "-", OPx, "123", NUMLITx, "e", IDx, "-", OPx,
  "456", NUMLITx }, "-num with -exp")
checkLex(t, "123E456", { "123E456", NUMLITx }, "num with Exp")
checkLex(t, "123E+456", { "123E+456", NUMLITx }, "num with +Exp")
checkLex(t, "123E-456", { "123", NUMLITx, "E", IDx, "-", OPx,
  "456", NUMLITx }, "num with -Exp")
checkLex(t, "+123E456", { "+", OPx, "123E456", NUMLITx },
  "+num with Exp")
checkLex(t, "+123E+456", { "+", OPx, "123E+456", NUMLITx },
  "+num with +Exp")
checkLex(t, "+123E-456", { "+", OPx, "123", NUMLITx, "E", IDx, "-", OPx,
  "456", NUMLITx }, "+num with -Exp")
checkLex(t, "-123E456", { "-", OPx, "123E456", NUMLITx },
  "-num with Exp")
checkLex(t, "-123E+456", { "-", OPx, "123E+456", NUMLITx },
  "-num with +Exp")
checkLex(t, "-123E-456", { "-", OPx, "123", NUMLITx, "E", IDx, "-", OPx,
  "456", NUMLITx }, "-num with -Exp")

checkLex(t, "1.2e34", { "1", NUMLITx, ".", PUNCTx, "2e34", NUMLITx },
  "num with dot, exp")
checkLex(t, "12e3.4", { "12e3", NUMLITx, ".", PUNCTx, "4", NUMLITx },
  "num, exp with dot")

checkLex(t, "e", { "e", IDx }, "Just e")
checkLex(t, "E", { "E", IDx }, "Just E")
checkLex(t, "e3", { "e3", IDx }, "e3")
checkLex(t, "E3", { "E3", IDx }, "E3")
checkLex(t, "e+3", { "e", IDx, "+", OPx, "3", NUMLITx }, "e+3")
checkLex(t, "E+3", { "E", IDx, "+", OPx, "3", NUMLITx }, "E+3")
checkLex(t, "1e3", { "1e3", NUMLITx }, "1e3")
checkLex(t, "123e", { "123", NUMLITx, "e", IDx }, "num e")
checkLex(t, "123E", { "123", NUMLITx, "E", IDx }, "num E")
checkLex(t, "123ee", { "123", NUMLITx, "ee", IDx }, "num ee #1")
checkLex(t, "123Ee", { "123", NUMLITx, "Ee", IDx }, "num ee #2")
checkLex(t, "123eE", { "123", NUMLITx, "eE", IDx }, "num ee #3")
checkLex(t, "123EE", { "123", NUMLITx, "EE", IDx }, "num ee #4")
checkLex(t, "123ee1", { "123", NUMLITx, "ee1", IDx }, "num ee num #1")
checkLex(t, "123Ee1", { "123", NUMLITx, "Ee1", IDx }, "num ee num #2")
checkLex(t, "123eE1", { "123", NUMLITx, "eE1", IDx }, "num ee num #3")
checkLex(t, "123EE1", { "123", NUMLITx, "EE1", IDx }, "num ee num #4")
checkLex(t, "123e+", { "123", NUMLITx, "e", IDx, "+", OPx }, "num e+ #1")
checkLex(t, "123E+", { "123", NUMLITx, "E", IDx, "+", OPx }, "num e+ #2")
checkLex(t, "123e-", { "123", NUMLITx, "e", IDx, "-", OPx }, "num e- #1")
checkLex(t, "123E-", { "123", NUMLITx, "E", IDx, "-", OPx }, "num e- #2")
checkLex(t, "123e+e7", { "123", NUMLITx, "e", IDx, "+", OPx, "e7", IDx },
  "num e+e7")
checkLex(t, "123e-e7", { "123", NUMLITx, "e", IDx, "-", OPx, "e7", IDx },
  "num e-e7")
checkLex(t, "123e7e", { "123e7", NUMLITx, "e", IDx }, "num e7e")
checkLex(t, "123e+7e", { "123e+7", NUMLITx, "e", IDx }, "num e+7e")
checkLex(t, "123e-7e", { "123", NUMLITx, "e", IDx, "-", OPx, "7", NUMLITx,
  "e", IDx }, "num e-7e")
checkLex(t, "123f7", { "123", NUMLITx, "f7", IDx }, "num f7 #1")
checkLex(t, "123F7", { "123", NUMLITx, "F7", IDx }, "num f7 #2")
checkLex(t, "123e++2", { "123", NUMLITx, "e", IDx, "++", OPx, "2", NUMLITx },
  "num e++2")

checkLex(t, "123 e+7", { "123", NUMLITx, "e", IDx, "+", OPx, "7", NUMLITx },
  "space-separated exp #1")
checkLex(t, "123 e-7", { "123", NUMLITx, "e", IDx, "-", OPx, "7", NUMLITx },
  "space-separated exp #2")
checkLex(t, "123e1 2", { "123e1", NUMLITx, "2", NUMLITx },
  "space-separated exp #3")
checkLex(t, "123e 12", { "123", NUMLITx, "e", IDx, "12", NUMLITx },
  "space-separated exp #4")
checkLex(t, "123else", { "123", NUMLITx, "else", KEYx },
  "number else")
checkLex(t, "1e2e3", { "1e2", NUMLITx, "e3", IDx },
  "number exponent #1")
checkLex(t, "1e+2e3", { "1e+2", NUMLITx, "e3", IDx },
  "number exponent #2")
checkLex(t, "1e-2e3", { "1", NUMLITx, "e", IDx, "-", OPx, "2e3", NUMLITx },
  "number exponent #3")

twostr = "2"
longexp = twostr:rep(10000)
checkLex(t, "3e" .. longexp, { "3e" .. longexp, NUMLITx }, "long exp #1")
checkLex(t, "3e" .. longexp .. "-", { "3e" .. longexp, NUMLITx, "-", OPx },
  "long exp #2")
checkLex(t, "''", { "''", STRLITx }, "Empty single-quoted str")
checkLex(t, "\"\"", { "\"\"", STRLITx }, "Empty double-quoted str")
checkLex(t, "'a'", { "'a'", STRLITx }, "1-char single-quoted str")
checkLex(t, "\"b\"", { "\"b\"", STRLITx }, "1-char double-quoted str")
checkLex(t, "'abc eol'", { "'abc eol'", STRLITx },
  "longer single-quoted str")
checkLex(t, "\"The quick brown fox.\"",
  { "\"The quick brown fox.\"", STRLITx },
  "medium-sized double-quoted str")
checkLex(t, "'aa\"bb'", { "'aa\"bb'", STRLITx },
  "single-quoted str with double quote")
checkLex(t, "\"cc'dd\"", { "\"cc'dd\"", STRLITx },
  "double-quoted str with single quote")
checkLex(t, "'aabbcc", { "'aabbcc", MALx },
  "partial single-quoted str #1")
checkLex(t, "'aabbcc\"", { "'aabbcc\"", MALx },
  "partial single-quoted str #2")
checkLex(t, "'aabbcc\n", { "'aabbcc", MALx },
  "partial single-quoted str #3")
checkLex(t, "\"aabbcc", { "\"aabbcc", MALx },
  "partial double-quoted str #1")
checkLex(t, "\"aabbcc'", { "\"aabbcc'", MALx },
  "partial double-quoted str #2")
checkLex(t, "\"aabbcc\n", { "\"aabbcc", MALx },
  "partial double-quoted str #3")
checkLex(t, "\"aabbcc\nd", { "\"aabbcc", MALx, "d", IDx },
  "partial double-quoted str #4")
checkLex(t, "'\"'\"'\"", { "'\"'", STRLITx, "\"'\"", STRLITx },
  "multiple strs")
checkLex(t, "\"#\"#\"\n\"\n\"", { "\"#\"", STRLITx, "\"", MALx,
    "\"", MALx },
  "strs & comments")
checkLex(t, "\"a\"a\"a\"a\"",
  { "\"a\"", STRLITx, "a", IDx, "\"a\"", STRLITx, "a", IDx,
    "\"", MALx }, "strs & identifiers")
checkLex(t, "\"abc\n\n\nif\"", { "\"abc", MALx, "if", KEYx, "\"", MALx },
  "double-quoted string containing newlines")
checkLex(t, "\"\\a\"", { "\"\\a\"", STRLITx },
  "string with an escape code")
checkLex(t, "a" .. longstr_d .. "b", { "a", IDx, longstr_d, STRLITx,
    "b", IDx },
  "very long str #2")
checkLex(t, "!", { "!", OPx }, "! alone")
checkLex(t, "&&", { "&&", OPx }, "&& alone")
checkLex(t, "||", { "||", OPx }, "|| alone")
checkLex(t, "==", { "==", OPx }, "== alone")
checkLex(t, "!=", { "!=", OPx }, "!= alone")
checkLex(t, "<", { "<", OPx }, "< alone")
checkLex(t, "<=", { "<=", OPx }, "<= alone")
checkLex(t, ">", { ">", OPx }, "> alone")
checkLex(t, ">=", { ">=", OPx }, ">= alone")
checkLex(t, "+", { "+", OPx }, "+ alone")
checkLex(t, "-", { "-", OPx }, "- alone")
checkLex(t, "*", { "*", OPx }, "* alone")
checkLex(t, "/", { "/", OPx }, "/ alone")
checkLex(t, "%", { "%", OPx }, "% alone")
checkLex(t, "[", { "[", OPx }, "[ alone")
checkLex(t, "]", { "]", OPx }, "] alone")
checkLex(t, "=", { "=", OPx }, "= alone")
checkLex(t, "++", { "++", OPx }, "++ alone")
checkLex(t, "--", { "--", OPx }, "-- alone")

-- Operator followed by digit
checkLex(t, "!1", { "!", OPx, "1", NUMLITx }, "! 1")
checkLex(t, "&&1", { "&&", OPx, "1", NUMLITx }, "&& 1")
checkLex(t, "||1", { "||", OPx, "1", NUMLITx }, "|| 1")
checkLex(t, "==1", { "==", OPx, "1", NUMLITx }, "== 1")
checkLex(t, "!=1", { "!=", OPx, "1", NUMLITx }, "!= 1")
checkLex(t, "<1", { "<", OPx, "1", NUMLITx }, "< 1")
checkLex(t, "<=1", { "<=", OPx, "1", NUMLITx }, "<= 1")
checkLex(t, ">1", { ">", OPx, "1", NUMLITx }, "> 1")
checkLex(t, ">=1", { ">=", OPx, "1", NUMLITx }, ">= 1")
checkLex(t, "+1", { "+", OPx, "1", NUMLITx }, "+ 1")
checkLex(t, "-1", { "-", OPx, "1", NUMLITx }, "- 1")
checkLex(t, "*1", { "*", OPx, "1", NUMLITx }, "* 1")
checkLex(t, "/1", { "/", OPx, "1", NUMLITx }, "/ 1")
checkLex(t, "%1", { "%", OPx, "1", NUMLITx }, "% 1")
checkLex(t, "[1", { "[", OPx, "1", NUMLITx }, "[ 1")
checkLex(t, "]1", { "]", OPx, "1", NUMLITx }, "] 1")
checkLex(t, "=1", { "=", OPx, "1", NUMLITx }, "= 1")
checkLex(t, "++1", { "++", OPx, "1", NUMLITx }, "++ 1")
checkLex(t, "--1", { "--", OPx, "1", NUMLITx }, "-- 1")

-- Operator followed by letter
checkLex(t, "!a", { "!", OPx, "a", IDx }, "! a")
checkLex(t, "&&a", { "&&", OPx, "a", IDx }, "&& a")
checkLex(t, "||a", { "||", OPx, "a", IDx }, "|| a")
checkLex(t, "==a", { "==", OPx, "a", IDx }, "== a")
checkLex(t, "!=a", { "!=", OPx, "a", IDx }, "!= a")
checkLex(t, "<a", { "<", OPx, "a", IDx }, "< a")
checkLex(t, "<=a", { "<=", OPx, "a", IDx }, "<= a")
checkLex(t, ">a", { ">", OPx, "a", IDx }, "> a")
checkLex(t, ">=a", { ">=", OPx, "a", IDx }, ">= a")
checkLex(t, "+a", { "+", OPx, "a", IDx }, "+ a")
checkLex(t, "-a", { "-", OPx, "a", IDx }, "- a")
checkLex(t, "*a", { "*", OPx, "a", IDx }, "* a")
checkLex(t, "/a", { "/", OPx, "a", IDx }, "/ a")
checkLex(t, "%a", { "%", OPx, "a", IDx }, "% a")
checkLex(t, "[a", { "[", OPx, "a", IDx }, "[ a")
checkLex(t, "]a", { "]", OPx, "a", IDx }, "] a")
checkLex(t, "=a", { "=", OPx, "a", IDx }, "= a")
checkLex(t, "++a", { "++", OPx, "a", IDx }, "++ a")
checkLex(t, "--a", { "--", OPx, "a", IDx }, "-- a")

-- Operator followed by "*"
checkLex(t, "!*", { "!", OPx, "*", OPx }, "! *")
checkLex(t, "&&*", { "&&", OPx, "*", OPx }, "&& *")
checkLex(t, "||*", { "||", OPx, "*", OPx }, "|| *")
checkLex(t, "==*", { "==", OPx, "*", OPx }, "== *")
checkLex(t, "!=*", { "!=", OPx, "*", OPx }, "!= *")
checkLex(t, "<*", { "<", OPx, "*", OPx }, "< *")
checkLex(t, "<=*", { "<=", OPx, "*", OPx }, "<= *")
checkLex(t, ">*", { ">", OPx, "*", OPx }, "> *")
checkLex(t, ">=*", { ">=", OPx, "*", OPx }, ">= *")
checkLex(t, "+*", { "+", OPx, "*", OPx }, "+ *")
checkLex(t, "-*", { "-", OPx, "*", OPx }, "- *")
checkLex(t, "**", { "*", OPx, "*", OPx }, "* *")
checkLex(t, "/*", { "/", OPx, "*", OPx }, "/ *")
checkLex(t, "%*", { "%", OPx, "*", OPx }, "% *")
checkLex(t, "[*", { "[", OPx, "*", OPx }, "[ *")
checkLex(t, "]*", { "]", OPx, "*", OPx }, "] *")
checkLex(t, "=*", { "=", OPx, "*", OPx }, "= *")
checkLex(t, "++*", { "++", OPx, "*", OPx }, "++ *")
checkLex(t, "--*", { "--", OPx, "*", OPx }, "-- *")

-- Operator followed by "="
checkLex(t, "!=", { "!=", OPx, }, "! =")
checkLex(t, "&&=", { "&&", OPx, "=", OPx }, "&& =")
checkLex(t, "||=", { "||", OPx, "=", OPx }, "|| =")
checkLex(t, "===", { "==", OPx, "=", OPx }, "== =")
checkLex(t, "!==", { "!=", OPx, "=", OPx }, "!= =")
checkLex(t, "<=", { "<=", OPx, }, "< =")
checkLex(t, "<==", { "<=", OPx, "=", OPx }, "<= =")
checkLex(t, ">=", { ">=", OPx }, "> =")
checkLex(t, ">==", { ">=", OPx, "=", OPx }, ">= =")
checkLex(t, "+=", { "+", OPx, "=", OPx }, "+ =")
checkLex(t, "-=", { "-", OPx, "=", OPx }, "- =")
checkLex(t, "*=", { "*", OPx, "=", OPx }, "* =")
checkLex(t, "/=", { "/", OPx, "=", OPx }, "/ =")
checkLex(t, "%=", { "%", OPx, "=", OPx }, "% =")
checkLex(t, "[=", { "[", OPx, "=", OPx }, "[ =")
checkLex(t, "]=", { "]", OPx, "=", OPx }, "] =")
checkLex(t, "==", { "==", OPx }, "= =")
checkLex(t, "++=", { "++", OPx, "=", OPx }, "++ =")
checkLex(t, "--=", { "--", OPx, "=", OPx }, "-- =")

-- Nonexistent operators
checkLex(t, "**", { "*", OPx, "*", OPx }, "NOT operator: **")
checkLex(t, "**2", { "*", OPx, "*", OPx, "2", NUMLITx },
  "NOT operator: -- digit")
checkLex(t, ".", { ".", PUNCTx }, "NOT operator: .")
checkLex(t, "+=", { "+", OPx, "=", OPx }, "NOT operator: +=")
checkLex(t, "+==", { "+", OPx, "==", OPx }, "NOT operator: +==")
checkLex(t, "-=", { "-", OPx, "=", OPx }, "NOT operator: -=")
checkLex(t, "-==", { "-", OPx, "==", OPx }, "NOT operator: -==")
checkLex(t, "*=", { "*", OPx, "=", OPx }, "NOT operator: *=")
checkLex(t, "*==", { "*", OPx, "==", OPx }, "NOT operator: *==")
checkLex(t, "/=", { "/", OPx, "=", OPx }, "NOT operator: /=")
checkLex(t, "/==", { "/", OPx, "==", OPx }, "NOT operator: /==")
checkLex(t, ":", { ":", PUNCTx }, "NOT operator: :")
checkLex(t, "::", { ":", PUNCTx, ":", PUNCTx }, "NOT operator: ::")
checkLex(t, ".", { ".", PUNCTx }, "NOT operator: .")
checkLex(t, "..", { ".", PUNCTx, ".", PUNCTx }, "NOT operator: ..")
checkLex(t, ",", { ",", PUNCTx }, "NOT operator: ,")
checkLex(t, "^", { "^", PUNCTx }, "NOT operator: ^")
checkLex(t, "^=", { "^", PUNCTx, "=", OPx }, "NOT operator: ^=")
checkLex(t, "~", { "~", PUNCTx }, "NOT operator: ~")
checkLex(t, "~=", { "~", PUNCTx, "=", OPx }, "NOT operator: ~=")
checkLex(t, "!!", { "!", OPx, "!", OPx }, "NOT operator: !!")
checkLex(t, "&", { "&", PUNCTx }, "NOT operator: &")
checkLex(t, "|", { "|", PUNCTx }, "NOT operator: |")
checkLex(t, "<<", { "<", OPx, "<", OPx }, "NOT operator: <<")
checkLex(t, ">>", { ">", OPx, ">", OPx }, "NOT operator: >>")
checkLex(t, "->", { "-", OPx, ">", OPx }, "NOT operator: ->")
checkLex(t, ".*", { ".", PUNCTx, "*", OPx }, "NOT operator: .>")
checkLex(t, "->*", { "-", OPx, ">", OPx, "*", OPx }, "NOT operator: ->*")
checkLex(t, "?", { "?", PUNCTx, }, "NOT operator: ?")
checkLex(t, "//", { "/", OPx, "/", OPx, }, "NOT operator: //")
checkLex(t, "<>", { "<", OPx, ">", OPx, }, "NOT operator: <>")

-- More complex stuff
checkLex(t, "+-++--", { "+", OPx, "-", OPx, "++", OPx, "--", OPx }, "+-++--")
checkLex(t, "+++++", { "++", OPx, "++", OPx, "+", OPx }, "+++++")
checkLex(t, "-----", { "--", OPx, "--", OPx, "-", OPx }, "-----")
checkLex(t, "=====", { "==", OPx, "==", OPx, "=", OPx }, "=====")
checkLex(t, "=<<==", { "=", OPx, "<", OPx, "<=", OPx, "=", OPx }, "=<<==")
checkLex(t, "**/ ", { "*", OPx, "*", OPx, "/", OPx }, "**/ ")
checkLex(t, "= =", { "=", OPx, "=", OPx }, "= =")
checkLex(t, "+++1+", { "++", OPx, "+", OPx, "1", NUMLITx, "+", OPx },
  "+++1+")
checkLex(t, "---2-", { "--", OPx, "-", OPx, "2", NUMLITx, "-", OPx },
  "---2-")

-- Punctuation chars
checkLex(t, "$(),.:;?@\\^`{}~",
  { "$", PUNCTx, "(", PUNCTx, ")", PUNCTx, ",", PUNCTx, ".", PUNCTx,
    ":", PUNCTx, ";", PUNCTx, "?", PUNCTx, "@", PUNCTx, "\\", PUNCTx,
    "^", PUNCTx, "`", PUNCTx, "{", PUNCTx, "}", PUNCTx, "~", PUNCTx },
  "assorted punctuation")
checkLex(t, "\001", { "\001", MALx }, "Single illegal character #1")
checkLex(t, "\031", { "\031", MALx }, "Single illegal character #2")
checkLex(t, "\001 \002", { "\001", MALx, "\002", MALx },
  "Illegal characters & whitespace")
checkLex(t, "a\002bcd\003\004ef",
  { "a", IDx, "\002", MALx, "bcd", IDx, "\003", MALx,
    "\004", MALx, "ef", IDx },
  "Various illegal characters")
checkLex(t, "a#\001\002\nb", { "a", IDx, "b", IDx },
  "Illegal characters in comment")
checkLex(t, "b'\001\002'", { "b", IDx, "'\001\002'", STRLITx },
  "Illegal characters in single-quoted string")
checkLex(t, "c\"\001\002\"", { "c", IDx, "\"\001\002\"", STRLITx },
  "Illegal characters in double-quoted string")
checkLex(t, "b'\001\002", { "b", IDx, "'\001\002", MALx },
  "Illegal characters in single-quoted partial string")
checkLex(t, "c\"\001\002", { "c", IDx, "\"\001\002", MALx },
  "Illegal characters in double-quoted partial string")
checkLex(t, " ", {}, "Single space character #1")
checkLex(t, "\t", {}, "Single space character #2")
checkLex(t, "\n", {}, "Single space character #3")
checkLex(t, "\r", {}, "Single space character #4")
checkLex(t, "\f", {}, "Single space character #5")
checkLex(t, "ab 12", { "ab", IDx, "12", NUMLITx },
  "Space-separated lexemes #1")
checkLex(t, "ab\t12", { "ab", IDx, "12", NUMLITx },
  "Space-separated lexemes #2")
checkLex(t, "ab\n12", { "ab", IDx, "12", NUMLITx },
  "Space-separated lexemes #3")
checkLex(t, "ab\r12", { "ab", IDx, "12", NUMLITx },
  "Space-separated lexemes #4")
checkLex(t, "ab\f12", { "ab", IDx, "12", NUMLITx },
  "Space-separated lexemes #5")

-- Comments
checkLex(t, "#abcd\n", {}, "Comment")
checkLex(t, "12#abcd\nab", { "12", NUMLITx, "ab", IDx },
  "Comment-separated lexemes")
checkLex(t, "12#abcd", { "12", NUMLITx }, "Unterminated comment #1")
checkLex(t, "12#abcd#", { "12", NUMLITx }, "Unterminated comment #2")
checkLex(t, "ab#\"", { "ab", IDx }, "Comment containing double quote")
checkLex(t, "ab#'", { "ab", IDx }, "Comment containing single quote")
checkLex(t, "12#a\n#b\n#c\nab", { "12", NUMLITx, "ab", IDx },
  "Multiple comments #1")
checkLex(t, "12#a\n  #b\n \n #c\nab", { "12", NUMLITx, "ab", IDx },
  "Multiple comments #2")
checkLex(t, "12#a\n=#b\n.#c\nab",
  { "12", NUMLITx, "=", OPx, ".", PUNCTx, "ab", IDx },
  "Multiple comments #3")
checkLex(t, "a##\nb", { "a", IDx, "b", IDx }, "Comment with hash 1")
checkLex(t, "a##b", { "a", IDx }, "Comment with hash 2")
checkLex(t, "a##b\n\nc", { "a", IDx, "c", IDx }, "Comment with hash 3")
checkLex(t, "", {}, "Empty program")

-- Very short program with shebang line
checkLex(t, "#!./tamandua.lua\n" ..
  "print(\"Type a number: \");\n" ..
  "n = readint();\n" ..
  "println('You entered: ', n);",
  { "print", KEYx, "(", PUNCTx, "\"Type a number: \"", STRLITx,
    ")", PUNCTx, ";", PUNCTx, "n", IDx, "=", OPx, "readint", KEYx,
    "(", PUNCTx, ")", PUNCTx, ";", PUNCTx, "println", KEYx, "(", PUNCTx,
    "'You entered: '", STRLITx, ",", PUNCTx, "n", IDx, ")", PUNCTx,
    ";", PUNCTx },
  "Very short program with shebang line")

-- Short program, little whitespace
checkLex(t, "a_1[0]=1;" ..
  "a_1[a_1[0]]=a_1[0]+2;" ..
  "_b2b=a_1[0]+3;" ..
  "if(_b2b==6){println(\"good\");}" ..
  "elsif(_b2b>6){println(\"too high\");}" ..
  "else{println(\"too low\");}",
  { "a_1", IDx, "[", OPx, "0", NUMLITx, "]", OPx, "=",
    OPx, "1", NUMLITx, ";", PUNCTx,
    "a_1", IDx, "[", OPx, "a_1", IDx, "[", OPx, "0", NUMLITx, "]", OPx,
    "]", OPx, "=", OPx, "a_1", IDx, "[", OPx, "0", NUMLITx, "]", OPx,
    "+", OPx, "2", NUMLITx, ";", PUNCTx,
    "_b2b", IDx, "=", OPx, "a_1", IDx, "[", OPx, "0", NUMLITx, "]", OPx,
    "+", OPx, "3", NUMLITx, ";", PUNCTx,
    "if", KEYx, "(", PUNCTx, "_b2b", IDx, "==", OPx, "6", NUMLITx,
    ")", PUNCTx, "{", PUNCTx,
    "println", KEYx, "(", PUNCTx, "\"good\"", STRLITx,
    ")", PUNCTx, ";", PUNCTx, "}", PUNCTx,
    "elsif", KEYx, "(", PUNCTx, "_b2b", IDx, ">", OPx, "6", NUMLITx,
    ")", PUNCTx, "{", PUNCTx, "println", KEYx,
    "(", PUNCTx, "\"too high\"", STRLITx,
    ")", PUNCTx, ";", PUNCTx, "}", PUNCTx,
    "else", KEYx, "{", PUNCTx, "println", KEYx, "(", PUNCTx,
    "\"too low\"", STRLITx,
    ")", PUNCTx, ";", PUNCTx, "}", PUNCTx },
  "Short program, little whitespace")

-- Fibonacci program from slides
checkLex(t,
  "# fibo (param in variable n)\n" ..
  "# Return Fibonacci number F(n).\n" ..
  "func fibo() {\n" ..
  "    currfib = 0;\n" ..
  "    nextfib = 1;\n" ..
  "    i = 0;  # Loop counter\n" ..
  "    while(i < n) {\n" ..
  "        # Advance (currfib, nextfib)\n" ..
  "        tmp = currfib + nextfib;\n" ..
  "        currfib = nextfib;\n" ..
  "        nextfib = tmp;\n" ..
  "        ++i;\n" ..
  "    }\n" ..
  "    return currfib;\n" ..
  "}\n" ..
  "\n" ..
  "# Main program\n" ..
  "# Print some Fibonacci numbers\n" ..
  "how_many_to_print = 20;\n" ..
  "\n" ..
  "println(\"Fibonacci Numbers\");\n" ..
  "\n" ..
  "j = 0;  # Loop counter\n" ..
  "while(j < how_many_to_print) {\n" ..
  "    n = j;  # Set param for fibo\n" ..
  "    ff = fibo();\n" ..
  "    println(\"F(\",j,\") = \",ff);\n" ..
  "    ++j;\n" ..
  "}\n" ..
  "println();\n",
  { "func", KEYx, "fibo", IDx, "(", PUNCTx, ")", PUNCTx, "{", PUNCTx,
    "currfib", IDx, "=", OPx, "0", NUMLITx, ";", PUNCTx,
    "nextfib", IDx, "=", OPx, "1", NUMLITx, ";", PUNCTx,
    "i", IDx, "=", OPx, "0", NUMLITx, ";", PUNCTx,
    "while", KEYx, "(", PUNCTx,
    "i", IDx, "<", OPx, "n", IDx, ")", PUNCTx, "{", PUNCTx,
    "tmp", IDx, "=", OPx, "currfib", IDx, "+", OPx, "nextfib", IDx,
    ";", PUNCTx,
    "currfib", IDx, "=", OPx, "nextfib", IDx, ";", PUNCTx,
    "nextfib", IDx, "=", OPx, "tmp", IDx, ";", PUNCTx,
    "++", OPx, "i", IDx, ";", PUNCTx,
    "}", PUNCTx,
    "return", KEYx, "currfib", IDx, ";", PUNCTx,
    "}", PUNCTx,
    "how_many_to_print", IDx, "=", OPx, "20", NUMLITx, ";", PUNCTx,
    "println", KEYx, "(", PUNCTx,
    "\"Fibonacci Numbers\"", STRLITx,
    ")", PUNCTx, ";", PUNCTx,
    "j", IDx, "=", OPx, "0", NUMLITx, ";", PUNCTx,
    "while", KEYx, "(", PUNCTx,
    "j", IDx, "<", OPx, "how_many_to_print", IDx, ")", PUNCTx,
    "{", PUNCTx,
    "n", IDx, "=", OPx, "j", IDx, ";", PUNCTx,
    "ff", IDx, "=", OPx, "fibo", IDx, "(", PUNCTx, ")", PUNCTx,
    ";", PUNCTx,
    "println", KEYx, "(", PUNCTx, "\"F(\"", STRLITx, ",", PUNCTx,
    "j", IDx, ",", PUNCTx, "\") = \"", STRLITx, ",", PUNCTx,
    "ff", IDx, ")", PUNCTx, ";", PUNCTx,
    "++", OPx, "j", IDx, ";", PUNCTx,
    "}", PUNCTx,
    "println", KEYx, "(", PUNCTx, ")", PUNCTx, ";", PUNCTx },
  "Fibonacci program from slides")

-- Program with other lexemes, little whitespace
checkLex(t, "if(!(1&&0||1)<2<=3>4>=5-6*7/8%9+a[3])){" ..
  "abcdefg_12345=00000;" ..
  "print(+123e45+-987E+65,+abcdefg_12345);" ..
  "}",
  { "if", KEYx, "(", PUNCTx, "!", OPx, "(", PUNCTx, "1", NUMLITx,
    "&&", OPx, "0", NUMLITx, "||", OPx, "1", NUMLITx, ")", PUNCTx,
    "<", OPx, "2", NUMLITx, "<=", OPx, "3", NUMLITx, ">", OPx,
    "4", NUMLITx, ">=", OPx, "5", NUMLITx, "-", OPx, "6", NUMLITx,
    "*", OPx, "7", NUMLITx, "/", OPx, "8", NUMLITx, "%", OPx,
    "9", NUMLITx, "+", OPx, "a", IDx, "[", OPx, "3", NUMLITx, "]", OPx,
    ")", PUNCTx, ")", PUNCTx, "{", PUNCTx,
    "abcdefg_12345", IDx, "=", OPx, "00000", NUMLITx, ";", PUNCTx,
    "print", KEYx, "(", PUNCTx,
    "+", OPx, "123e45", NUMLITx, "+", OPx, "-", OPx,
    "987E+65", NUMLITx, ",", PUNCTx, "+", OPx,
    "abcdefg_12345", IDx, ")", PUNCTx, ";", PUNCTx,
    "}", PUNCTx },
  "Program with other lexemes, little whitespace")
