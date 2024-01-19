#import "template.typ": *
#set text(size: 16pt)

= Day 3 - 1/19/2024

== Dot Product

Suppose we have the vectors $arrow(a) = vec(a_x, a_y, a_z)$ and $arrow(b) = vec(b_x, b_y, b_z)$.

Define $arrow(a) dot arrow(b) = a_x b_x + a_y b_y + a_z b_z$. Dot Products
produce scalar values.

Example:

$
  arrow(a) = vec(1, 2, 0) quad arrow(b) = vec(7, 5, 7)\
  arrow(a) dot arrow(b) = 1(7) + 2(5) + 0(7) = 7 + 10 + 0 = underline(17)
$

Properties: 
- Commutivity/Symmetry: $arrow(a) dot arrow(b) = arrow(b) dot arrow(a)$
- Linearity: $arrow(a), arrow(b), arrow(b) "- Vectors", r,s "- Scalars"$
  $ (arrow(a) + arrow(b)) dot arrow(c) = arrow(a) dot arrow(c) + arrow(b) dot arrow(c) $
  $ arrow(a) dot (arrow(b) + arrow(c)) = arrow(a) dot arrow(b) + arrow(a) dot arrow(c) $
  Possible if $r = 0$
  $ (s arrow(a)) dot arrow(b) = s(arrow(a) dot arrow(b)) = arrow(a) (s arrow(b)) $
  $ (s arrow(a) + r arrow(b)) dot arrow(c) = s(arrow(a) dot arrow(c)) + r(arrow(b) dot arrow(c)) $
- Length: $arrow(a) dot arrow(a) = ||arrow(a)||^2$
  $ arrow(a) = vec(1, 4, 5); arrow(b) = vec(3, 0, 2), arrow(c) = vec(1, 7, 7) $
  $ (arrow(a) dot arrow(b))arrow(c) = (3 + 0 + 10)arrow(c) = 13arrow(c) = vec(13, 91, 91) $

== Angles between Vectors

Suppose we have two vectors $arrow(a)$ and $arrow(u)$ and we want to find the
angle between the two.

+ Find $arrow(v) - arrow(u)$.
+ Use the _Law of cosines_.
  $ ||v-u||^2 = ||u||^2 + ||v||^2 - 2(||u||dot||v||)cos alpha $
  $ (v-u) dot (v-u) = v dot (v-u)-u(v-u) $
  $ v dot v - v dot u - u dot v + u dot u $
  $ "since" u dot v = v dot u: ||v||^2 - 2 u dot v + ||u||^2 $
  $ ||u||^2 + ||v||^2 - 2 ||u||||v||cos alpha = ||v||^2 - 2(u dot v) + ||u||^2 $
  $ u dot v = ||u||||v|| cos alpha $
  $ cos alpha = (u dot v)/(||u||||v||) $
  $ alpha = arccos((u dot v)/(||u||||v||)) $

Properties:

$
  u, v "- Vectors"; \
  quad u dot v > 0 => alpha < 90^degree \
  u dot v = 0 => alpha = 90^degree ("given" u "and" v "are not" arrow(0)); u bot v \
$

$
  "if" arrow(a) || arrow(b) => arrow(a) = k arrow(b) "where" k in RR \
  a dot b = k b dot b = k ||b||^2 \
  ||a|| dot ||b|| = |k| ||b||^2
$

== Orthogonal Projections

Define a vector $arrow(d) bot arrow(a)$ where $arrow(d)$ is the project of $arrow(b)$ onto $arrow(a)$ and $c dot arrow(d) = arrow(a)$.

$
  arrow(b) = c dot arrow(a) + arrow(d) \
  arrow(a) dot arrow(b) = c arrow(a) dot arrow(a) + arrow(d) dot arrow(a) \
  arrow(a) dot arrow(b) = c ||a||^2 \
  "proj"_(arrow(a))arrow(b) = (arrow(a) dot arrow(b)) / (||a||^2)
$
