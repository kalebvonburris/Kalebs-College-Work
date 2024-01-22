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
  + $arrow(R P) = vec(-1 - (-3), 3 - 7) = underline(vec(2, -4))$
  + $arrow(P Q) = underline(2 arrow(i) - 4 arrow(j))$
]

#prob(7)[
  + $arrow(P Q) = vec(2, 2)$, $arrow(P R) = -arrow(R P) = vec(-2, 4)$.
  Therefore: 
  $
    2 arrow(P Q) - 2 arrow(P R) &= 2 dot vec(2, 2) - 2 dot (-2,4)\ 
                                &= vec(4, 4) - (-4,8) \
                                &= underline(vec(8, -4))
  $
  b) $ underline(8 arrow(i) - 4 arrow(j)) $
]

#prob(9)[
  $||arrow(P Q)|| = sqrt(2^2 + 2^2) = sqrt(8) = 2 sqrt(2)$
  + $ underline(vec(1, 1)) $
  + $ underline(arrow(i) + arrow(j)) $
]

#prob(12)[
  $
    arrow(v) = vec(2 - (-1), 1 - (-3)) = vec(3, 4) \
    ||vec(v)|| = sqrt(3^2 + 4^2) = sqrt(9 + 16) = sqrt(25) = 5 \
    underline(vec(3/5, 4/5))
  $
]

#prob(
  14,
)[
  $
    arrow(v) = vec(x - 1, 0 - 1) = vec(x - 1, -1)\
    ||arrow(v)|| = sqrt(10) = sqrt((x-1)^2 + (-1)^2) = sqrt(x^2 - 2x + 2)
  $
]

#prob(17)[]

#prob(26)[]

#prob(30)[]

#prob(32)[]

#prob(38)[]

#prob(40)[]

#prob(46)[]