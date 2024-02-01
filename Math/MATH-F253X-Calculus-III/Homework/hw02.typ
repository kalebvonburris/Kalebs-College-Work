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