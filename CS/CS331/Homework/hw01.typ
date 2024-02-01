#import "template.typ": *
#import "@preview/cetz:0.2.0"
#import "@preview/finite:0.3.0": *

#let title = "Assignment 1"
#let author = "Kaleb Burris"
#let course_id = "CS-331"
#let instructor = "Glenn Chappell"
#let semester = "Spring 2024"
#let due_time = "1/26/2024"
#set enum(numbering: "1.")
#show: assignment_class.with(title, author, course_id, instructor, semester, due_time)

#set text(size: 16pt)

#prob("A")[
  #underline("BE SURE TO DRINK YOUR OVALTINE")
]

#prob("B")[
  + Type checking for C++ is primarily static.
  + This means that type checking is done at compile time instead of runtime.
]

#prob("C")[
  The grammar describes: [$a^n b^m c$] where $n >= 1, m >= 0$.

  The strings generated are: 1, 4, 5.
]

#prob("D")[
  The grammar describes all strings that:
  - Contains 0 or more $x$'s on the front,
  - Contains 0 or more pairs of $y$'s ($y y$),
  - Contains 0 or more $z$'s at the end.
]

#prob("E")[
  The regex is matched by: 3, 4, 5, 7.
]

#prob("F")[
  $
   [x y z]*y+[x y z]*
  $
]

#pagebreak()

#prob("G")[
  #show math.equation: set align(left)
  + $
    underline(S) \
    underline(S) S \
    x y underline(S) \
    x y x y
  $
  + $
    underline(S) \
    S underline(S) \
    underline(S) x y \
    x y x y

  $
  #show math.equation: set align(center)

  + #table(columns: 2, stroke: white, align: center, "Parse Tree 1", "Parse Tree 2", 
    cetz.canvas({
      import cetz.tree
      import cetz.draw: *
      set-style(content: (padding: .1))
      tree.tree((
        [S], 
        ([S], ([S], [x], [y]), ([S], [x], [y])), 
        ([S], [x], [y])
      ))
    })
  ,
    cetz.canvas({
      import cetz.tree
      import cetz.draw: *
      set-style(content: (padding: .1))
      tree.tree((
        [S], 
        ([S], [x], [y]), 
        ([S], ([S], [x], [y]), ([S], [x], [y]))
      ))})
  )
  + $
    S -> S x y | epsilon
  $ 
]

#pagebreak()

#prob("H")[
  + $(a a)* b?$
  + This one turned out pretty cool: 
  #align(center)[#automaton((
      A: (B: "a"),
      B: (B: "a", C: "b"),
      C: (D: ("a,b")),
      D: ()
    ),
    layout: layout.circular.with(spacing: 0.5),
    final: ("C"),
    style: (A: (initial: bottom)),
    labels: (A: [], B: [], C: [], D: [])
  )]
  #show math.equation: set align(left)
  3. $
    S -> a a B \
    B -> b|a B
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
        ([a], [a], ([B], [a], ([B], [a], ([$fence.dotted$], [b]))))
      ))
    })
  ]
]

#pagebreak()

#prob("I")[

]