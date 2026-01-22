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
)


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

This language contains all strings that are zero or more $c$'s, that are optionally contained between a pair of two $a$'s ($a a$) and $b$'s ($b b$) where the $a$'s are in front, and the $b$'s are behind the zero or more $c$'s.

== Exercise F

The regular expression $x * (a b | c)*$ contains the strings labeled $#rect[1, 3, 4, 5, 7]$.

== Exercise G

This regular expression matches all strings that have any number of $a$'s, $b$'s, and $c$'s and also have one $b$, by matching the arbitrary set of $[a b c]$ on either side of a $b$.

$
  #rect[$(a | b | c) * b (a | b | c) *$]
$

== Exercise H

1. No, this grammar contains the rule $S -> S a S$ which is not one of the accepted forms of productions for a regular grammar.

2. Yes, this grammar is context-free as all of its production's left sides are non-terminals.

3. #align(left, rect[
    S \
    S a S \
    b a S \
    b a b
  ])

4. #align(left, rect[
    S \
    S a S \
    S a b \
    b a b
  ])

5. The string $b a b a b$, has two different parse trees.

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

6. $
    S & -> b A \
    A & -> a S | epsilon
  $

== Exercise E

1. $x a a +$

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

3. $
    S & -> x a a A \
    A & -> a | epsilon
  $
