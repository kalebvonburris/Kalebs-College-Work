#import "template.typ": *
#import "@preview/cetz:0.2.0"
#import "@preview/finite:0.3.0": *

#let title = "Assignment 1"
#let author = "Kaleb Burris"
#let course_id = "CS-331"
#let instructor = "Glenn Chappell"
#let semester = "Spring 2025"
#let due_time = "1/30/2024"
#set enum(numbering: "1.")
#show: assignment_class.with(title, author, course_id, instructor, semester, due_time)

#set text(size: 16pt)

#prob("A")[
  #underline("BE SURE TO DRINK YOUR OVALTINE")
]

#prob("C")[
  + Type checking for C++ is mostly static.
  + This means that type checking is done at compile time instead of runtime. Some cases, such as type casting, do exist, but are rare.
]

#prob("D")[
  The strings generated are: 1, 4, 5.
]

#prob("E")[
  The grammar describes all strings that:
  - Start with one or more $a$'s,
  - Followed by 0 or more pairs of $c$'s ($c c$),
  - End with 1 or more b's.
]

#prob("F")[
  The regex is matched by: 3, 4, 5, 7.
]

#prob("G")[
  $
   a a* (a|b|c)*
  $
]

#pagebreak()

#prob("H")[
  #show math.equation: set align(left)
  + $
    underline(S) \
    underline(S) S \
    a b underline(S) \
    a b a b
  $
  + $
    underline(S) \
    S underline(S) \
    underline(S) a b \
    a b a b

  $
  #show math.equation: set align(center)

  + $"String:" \"a b a b a b\"$ #table(columns: 2, stroke: white, align: center, "Parse Tree 1", "Parse Tree 2", 
    cetz.canvas({
      import cetz.tree
      import cetz.draw: *
      set-style(content: (padding: .1))
      tree.tree((
        [S],
        ([S], ([X], [ab])),
        ([S], ([S], ([X], [ab])), ([S], ([X], [ab])))
      ))
    }),
  cetz.canvas({
      import cetz.tree
      import cetz.draw: *
      set-style(content: (padding: .1))
      tree.tree((
        [S],
        ([S], ([S], ([X], [ab])), ([S], ([X], [ab]))),
        ([S], ([X], [ab])),
      ))})
  )
  + $
    S -> S a b | epsilon
  $ 
]

#pagebreak()

#prob("I")[
  + $x x x* a$
  + #align(center)[#automaton((
      A: (B: "x"),
      B: (C: "x"),
      C: (C: "x", D: "a"),
      D: (E: ("x, a")),
      E: (E: ("x, a"))
    ),
    layout: layout.linear.with(spacing: 1.0),
    final: ("D"),
    style: (A: (initial: left)),
    labels: (A: [], B: [], C: [], D: [], E: [])
  )]
  #show math.equation: set align(left)
  3. $
    S -> x x B \
    B -> a|x B
  $
  #show math.equation: set align(center)
  + My grammar here is not ambiguous as it only has a single, potentially infinite path:

  #align(center)[
    #cetz.canvas({
      import cetz.tree
      import cetz.draw: *
      set-style(content: (padding: .1))
      tree.tree((
        [S], 
        [xx], ([B], [x], ([B], [x], ([B], [x], ([$fence.dotted$], [a]))))
      ))
    })
  ]
]

#pagebreak()

#show math.equation: set align(left)

#prob("J")[
  I had to wrap the reg-exp productions.
  #set text(size: 10pt)
  $
    <"reg-exp"> ::=& <"single-char"> <"reg-exp"> | \"(\" <"reg-exp"> \")\" | <"single-char"> <"kleene"> | \
                   & <"reg-exp"> \"|\" <"reg-exp"> | <"epsilon"> \
    <"kleene"> ::=& \"*\" \
  $
]
