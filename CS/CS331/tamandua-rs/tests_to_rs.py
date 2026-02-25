file = "lexit_test.lua"

tests = []

test_name_transformations = str.maketrans({
    "#": "",
    " ": "_",
    "-": "_dash_",
    "+": "_and_",
    "=": "_equals_",
    "<": "_lt_",
    ">": "_gt_",
    ".": "_dot_",
    "*": "_star_",
    "/": "_slash_",
    "?": "_question_mark_",
    "[": "_open_bracket_",
    "]": "_close_bracket_",
    "|": "_pipe_",
    "%": "_percent_",
    "\n": "",
    "(": "",
    ")": "",
    ",": "",
})

test_ids_to_rust = {
    "KEYx": "Keyword",
    "IDx": "Identifier",
    "NUMLITx": "NumericLiteral",
    "STRLITx": "StringLiteral",
    "OPx": "Operator",
    "PUNCTx": "Punctuation",
    "MALx": "Malformed",
}

with open(file, "r") as f:
    content = f.read().strip()
    # Remove newlines
    content = content
    while content.find("checkLex(") != -1:
        print(f"Parsing... {len(content)} characters left")

        content = content[content.find("checkLex(") + len("checkLex(") :]

        # Remove t
        content = content[content.find("t,") + len("t,") :].strip()

        # We need to parse from the open { to its closing }, which is the last character before the first ) after the checkLex(.
        line = content[: content.find("checkLex(")].strip().strip()

        open_brace_index = line.find('{')

        close_brace_index = line.rfind("}", open_brace_index)

        test_input = line[:line.find('",')].strip()

        if test_input.find('..') != -1:
            new_test_input = ""

            for l in test_input.split('" ..\n'):
                l = l.replace(' "', '').strip('"')
                new_test_input += l

            test_input = new_test_input

        test_input = test_input.strip(',"')

        test_name = line[close_brace_index + 1 : line.rfind(")")].strip()

        test_name = test_name[test_name.find('"'):]

        test_name = test_name.strip().lower().translate(test_name_transformations).replace("__", "_").strip("_")

        test_identifier = line[open_brace_index + 1 : close_brace_index].strip().replace("\n", "")

        test_ids_arr = [x.strip() for x in test_identifier.split(", ")]

        test_ids = []

        for i in range(0, int(len(test_ids_arr) / 2)):
            test_ids.append((test_ids_arr[i*2], test_ids_to_rust[test_ids_arr[i*2 + 1]]))

        tests.append((test_name, test_input, test_ids))

for test in tests:
    print(f"test_name: ({test[0]})\n    test_input: \"{test[1]}\"\n    test_identifier: {test[2]}")


