#import "@preview/tdtr:0.5.0": *

#set text(size: 12pt, font: "FiraCode Nerd Font")

#set page(
  header: align(right, [
    Kaleb Burris \
    CS 331 - Programming Languages \
    Assignment 1 \
    #line(length: 100%)
  ]),
  margin: (top: 1.5in, x: 0.5in),
  numbering: "1",
)

#show math.text: set text(font: "FiraCode Nerd Font Mono")

== Exercise A

#align(center, rect["BE SURE TO DRINK YOUR OVALTINE"])

== Exercise B

#align(center, ":)")

== Exercise C

1. Although the use of `let` allows for more dynamic typing, Swift primarily uses static typing.

2. This means that type checking is done in the static context - before runtime. Errors about invalid typing are thrown before the program ever executes.

== Exercise D

The grammar can be also represented with the regular expression $r o * z +$

The grammar contains the strings $#rect[1, 3, and 5]$.

== Exercise E

This language contains all strings that start with $n$ many pairs of $a$'s ($a a$), where $n$ is greater than or equal to $0$, followed by zero or more $c$'s, and ended by $n$ many pairs of $b$'s ($b b$).

== Exercise F

The regular expression $x * (a b | c)*$ contains the strings labeled $#rect[1, 3, 4, 5, and 7]$.

== Exercise G

This regular expression matches all strings that have any number of $a$'s, $b$'s, and $c$'s and also have one $b$, by matching the arbitrary set of $[a b c]$ on either side of a singular $b$.

$
  #rect[$(a | b | c) * b (a | b | c) *$]
$

== Exercise H

1. No, this grammar contains the rule $S -> S a S$ which is not one of the accepted forms of productions for a regular grammar. We have to track how many $S$'s are generated on both sides of the $a$.

2. Yes, this grammar is context-free as all of its productions' left sides contain a single non-terminal.

#table(
  columns: (1fr, 1fr),
  stroke: none,
  [
    3. Leftmost:
      #align(center, rect[$
        & S \
        & S a S \
        & b a S \
        & b a b
      $])
  ],
  [
    4. Rightmost:
      #align(center, rect[$
        & S \
        & S a S \
        & S a b \
        & b a b
      $])
  ],
)
5. The string $b a b a b$ has two different parse trees.

#table(
  columns: (1fr, 1fr),
  stroke: none,
  align: center,
  [Parse tree one: \
    #tidy-tree-graph(compact: true, text-size: 12pt, draw-node: ((label,)) => (stroke: none, label: $label$))[
      - S
        - S
          - S
            - X
              - b
          - a
          - S
            - X
              - b
        - a
        - S
          - X
            - b
    ]],
  [Parse tree two: \
    #tidy-tree-graph(compact: true, text-size: 12pt, draw-node: ((label,)) => (stroke: none, label: $label$))[
      - S
        - S
          - X
            - b
        - a
        - S
          - S
            - X
              - b
          - a
          - S
            - X
              - b
    ]],
)

6. #rect[$
    S & -> b A \
    A & -> a S | epsilon
  $]

This is non-ambiguous as all derivations generate right-most derivations.

== Exercise E

1. #rect[$x a a +$]

#import "@preview/finite:0.5.0": automaton

2.
#align(center, [
  #automaton(
    (
      q0: (q1: "x"),
      q1: (q2: "a"),
      q2: (q3: "a"),
      q3: (q3: "a"),
    ),
    initial: "q0",
    final: "q3",
    labels: (q0: "", q1: "", q2: "", q3: ""),
  )
])

3. #rect[ $
    S & -> x a a A \
    A & -> a | epsilon
  $]

4. No, the grammar is not ambiguous as any derivation will always contain the first step, followed by $n$ many additional of the second steps for any number of $a$'s needed past two $a$'s. Since there are only two possible productions for $A$, and one of them is the empty string $epsilon$, there are no alternative ways to construct a string in the language from this grammar.

== Exercise J

The provided statements are given (NOT IN BNF FORM!!!):

$
  "<uc-letter>" & = "A-Z" \
  "<lc-letter>" & = "a-z" \
$

My solution is:

#align(center, rect[$
         "<name>" & = "<real-name>" "<middle-name>" "<real-name>" \
    "<real-name>" & = "<uc-letter>" "<lc-letter>" "<lc-tail>" \
      "<lc-tail>" & = "<lc-letter>" "<lc-tail>" | "\"\"" \
  "<middle-name>" & = "\" \"" | "\" \"" "<uc-letter>" "\". \""
$])

Note: $"\" \""$ is a single space character and $"\"\""$ is the empty string.
