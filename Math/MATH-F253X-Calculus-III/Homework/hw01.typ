#import "template.typ": *

#let title = "HW1"
#let author = "Kaleb Burris"
#let course_id = "MATH-253"
#let instructor = "Oleksandr Bobrovnikov (Sasha)"
#let semester = "Spring 2024"
#let due_time = "1/22/2024"
#set enum(numbering: "a)")
#show: assignment_class.with(title, author, course_id, instructor, semester, due_time)

#set text(size: 12pt)

= 2.1

#prob(4)[
  + $ arrow(R P) = vector(-1 - (-3), 3 - 7) = underline(vector(2, -4)) $
  + $ arrow(P Q) = underline(2 arrow(i) - 4 arrow(j)) $
]

#prob(
  7,
)[
  + $ arrow(P Q) = vector(2, 2)$, $arrow(P R) = -arrow(R P) = vector(-2, 4) $. Therefore: $
    2 arrow(P Q) - 2 arrow(P R) &= 2 dot vector(2, 2) - 2 dot (-2,4)\ 
                                &= vector(4, 4) - (-4,8) \
                                &= underline(vector(8, -4))
  $
  + $ underline(8 arrow(i) - 4 arrow(j)) $
]

#prob(9)[
  $||arrow(P Q)|| = sqrt(2^2 + 2^2) = sqrt(8) = 2 sqrt(2)$
  + $ underline(vector(1, 1)) $
  + $ underline(arrow(i) + arrow(j)) $
]

#prob(12)[
  $
    arrow(v) = vector(2 - (-1), 1 - (-3)) = vector(3, 4) \
    ||vector(v)|| = sqrt(3^2 + 4^2) = sqrt(9 + 16) = sqrt(25) = 5 \
    underline(vector(3/5, 4/5))
  $
]

#prob(
  14,
)[
  $
    arrow(v) = vector(x - 1, 0 - 1) = vector(x - 1, -1)\
    ||arrow(v)|| = sqrt(10) = sqrt((x-1)^2 + (-1)^2) = sqrt(x^2 - 2x + 2) \
    10 = x^2 - 2x + 2 \
    0 = x^2 - 2x - 8 \
    0 = (x+2) dot (x - 4) \
    x = 2, -4 \
    x "must be" -4: underline(Q(-2,0))
  $
]

#prob(17)[
  + $ arrow(a) = vector(-2, 4) quad arrow(b) = vector(-2, 2) \ 
    -3 vector(-2, 4) + vector(-2, 2) - 4i + j =
    vector(6, 12) + vector(-2, 2) + vector(-4, 0) + vector(0, 1) \
    = vector(0, 15); quad ||vector(0, 15)|| = underline(15) $
]

#prob(
  26,
)[
  $ ||v|| = 3, u = vector(-2, 5) $
  
  $
    sqrt((-2)^2 + 5^2) = sqrt(29) \
    3 vector((-2)/sqrt(29), 5/sqrt(29)) = underline(vector((-6)/sqrt(29), 15/sqrt(29)))
  $
]

#prob(30)[
  $
    arrow(u) = 6 vector(cos(60^degree), sin(60^degree)) =
    underline(vector(3, 3sqrt(3)))
  $
]

#prob(32)[
  $
    arrow(u) = 8 vector(-1, 0) = underline(vector(-8, 0))
  $
]

#prob(38)[
  $
    alpha = 0; beta = 0 \
    alpha = 2 beta \
    underline(alpha in RR\; beta = 2 alpha)
  $
]

#prob(40)[
  + $
    f'(x) = 4x^3; f'(1) = 4 \
    y = 4x + 1 => y = 4 + 1 = 5 \
    underline(Q(2, 5))
  $

  + $
    arrow(P Q) = vector(2 - 1, 5 - 1) = vector(1, 4); ||u|| = sqrt(1^2 + 4^2) = sqrt(17) \
    arrow(u) = underline(vector(1/sqrt(17), 4/sqrt(17)))
  $
]

#prob(46)[
  $
    theta = 30^degree \
    arrow(v) = 100 vector(cos(30^degree), sin(30^degree)) = vector(50, 50 sqrt(3)) \
    underline("Horizontal:" 50.00 "mph"\, "Vertical:" 86.60 "mph")
  $
]