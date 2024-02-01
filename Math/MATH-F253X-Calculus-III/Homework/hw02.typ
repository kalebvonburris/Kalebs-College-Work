#import "template.typ": *

#let title = "HW2"
#let author = "Kaleb Burris"
#let course_id = "MATH-253"
#let instructor = "Oleksandr Bobrovnikov (Sasha)"
#let semester = "Spring 2024"
#let due_time = "1/31/2024"
#set enum(numbering: "a)")
#show: assignment_class.with(title, author, course_id, instructor, semester, due_time)

#set text(size: 12pt)

= 2.4

#prob(184)[
  + $
    vector(3,2,-1) times vector(1,1,0) = i(0 + 1) - j(0 + 1) + k(3 - 2) = underline(i + j + k)
  $
  + Image
]

#prob(188)[
  $
    j times (k times j + 2 j times i - 3 j times j + 5 i times k) \
    = j times (-i - 2 k - 5 j) = underline(k - 2 i)
  $
]

#prob(190)[
  $  
    w = (u times v)/(||u times v||) \
    u times v = mat(delim: "|", i,j,k;2,6,1;3,0,1) = i(6-0) - j(2-3) + k(0-18) = 6 i + j - 18 k \
    ||u times v|| = sqrt(6^2 + 1^2 + 18^2) = sqrt(361) = 19 \
    w = (u times v)/(||u times v||) = underline((6 i)/19 + j/19 - (18 k)/19)
  $
]

#prob(195)[
  $arrow(u) times arrow(v)$ is by definition orthogonal to both $arrow(u)$ and $arrow(v)$. If we take the dot product of two vectors to be 0, that also defines them as being orthogonal. Therefore, $(arrow(u) times arrow(v)) dot (arrow(u) + arrow(v)) = 0 + 0$, and $(arrow(u) times arrow(v)) dot (arrow(u) - arrow(v)) = 0 - 0$, making $(arrow(u) times arrow(v))$ orthogonal to $arrow(u) + arrow(v)$ and $arrow(u) - arrow(v)$
]

#pagebreak()

#prob(204)[
  $
    sin alpha = (||u times v||)/(||u||||v||) \
    u times v = mat(delim: "|", i,j,k;-1,3,1;1,-2,0) = i(0+2) - j(0-1) + k(2-3) = 2 i + j - k \
    ||2 i + j - k|| = sqrt(2^2 + 1 + 1) = sqrt(6) \
    ||u|| = sqrt(1 + 3^2 + 1) = sqrt(11); quad ||v|| = sqrt(1 + 2^2) = sqrt(5) \
    sin alpha = sqrt(6)/(sqrt(11) dot sqrt(5)) \
    alpha = arcsin(sqrt(6)/(sqrt(11) dot sqrt(5))) approx 19.29^degree <- "Not obtuse!" \
    180 - 19.29 = 160.71; ceil(160.71) approx underline(161^degree)
  $
]

#prob(210)[
  $
    A = ||u times v|| \
    u times v = mat(delim: "|", i,j,k;1,1,0;1,0,1) = i(1 + 0) - j(0 - 1) + k(1 - 0) = i + j + k \
    ||u times v|| = sqrt(1 + 1 + 1) = underline(sqrt(3))
  $
]

#prob(212)[
  + 
]