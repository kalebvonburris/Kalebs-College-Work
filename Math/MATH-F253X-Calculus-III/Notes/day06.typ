#import "template.typ": *
#set text(size: 16pt)

= Day 6 - 1/25/2024

== Equation of a Plane

$
  "Given point" P(p_1, p_2, p_3) "on the plane": \
  a(x-p_1) + b(y-p_1) + c(z-p_3) = 0 \
  a x + b y + c z - underbrace(a p_1 - b p_2 - c p_3, d) = 0 \
  underbrace(a x + b y + c z + d = 0, "Final Form") \
  "In this form," vector(a,b,c) "is the normal vector from" P
$

$
  "Given" Q in "plane": \
  d = (arrow(Q P) dot arrow(n)) / (||arrow(n)||) \
$

Plane $A$ is spanned by $arrow(c) = vector(1,0,4)$ and $arrow(b) = vector(2,1,0)$, and $A$ passes through $(1,1,1)$.

Find the equation of $A$, and find the distance between $A$ and $P(0,0,0)$.

$
  1. "Find" arrow(u) = arrow(b) times arrow(c) = mat(delim: "|", i,j,k; 1,0,3;2,1,0) \
  = i(0-3) - j(0-6) + k(1-0) = vector(-3, 6, 1) \
  underline(-3(x-1)+6(y-1)+1(z-1)=0) \
  2. "Find the distance between" A "and" P(0,0,0) \
  (-3(0-1)+6(0-1)+(0-1))/sqrt((-3)^2+6^2+1^2) = (3-36-1)/sqrt(9-6-1) = underline((-4)/sqrt(46)) \1
$