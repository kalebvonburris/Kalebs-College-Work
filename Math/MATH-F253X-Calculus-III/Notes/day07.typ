#import "template.typ": *
#import "@preview/cetz:0.2.0": *

#set text(size: 16pt)

= Day 7 - 1/26/2024

== Vector Valued Functions

$
  f in RR^2 = vec(f_1, f_2) \
  f(t) = (f_1(t) + f_2(t)) = arrow(i) f_1(t) + arrow(j) f_2(t`) \
  f in RR^3 = vec(f_1, f_2, f_3) \
  f(t) = (f_1(t) + f_2(t) + f_3(t)) =  arrow(i) f_1(t) + arrow(j) f_2(t) + arrow(k) f_3(t) \
  "Given" f: [0, 2 pi) -> RR^2 \
  f(t) = (cos(t), sin(t)) = arrow(i) cos(t) + arrow(j) sin(t) \
  "Evaluate" f((3 pi)/4) = (cos((3 pi)/4), sin((3 pi)/4)) \
  = ((-sqrt(2))/2, sqrt(2)/2) = underline(-arrow(i) sqrt(2)/2 + arrow(j) sqrt(2)/2)
$

#underline("Theorem"): $ arrow(f(t)) = (f_1(t) + f_2(t) + f_3(t)) \
  lim_(t -> a) f_1(t) = A_1 \
  ||f(t)-A|| = sqrt((f_1 (t) - A_1)^2 + (f_2(t) + A_2)^2 + (f_3(t) + A_3)^2) -> 0 \
$
