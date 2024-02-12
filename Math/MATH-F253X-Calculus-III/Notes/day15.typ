#import "template.typ": *

#set text(size: 16pt)

= Day 15 - 2/12/2024

== Multivariate Functions

Suppose $
  f:(a,b) -> RR; c in (a,b) \
  lim_(x->c) epsilon > 0, exists delta > 0, 0 < |x-c| < delta => |f(x)-L| < epsilon \
  g: E -> RR; E subset RR^2; c in E \
  lim(x->c) f(x) = L \
  forall epsilon > 0, exists delta > 0, 0 < ||x-c|| < delta => |g(x)-L| < epsilon
$
$
  lim_(x->c^-) f(x) = L \
  lim_(x->c^+) f(x) = L
$

=== Limits

Examples:

+ $ lim_((x,y) -> (-1,0)) (2x^2 + 4x + 3x y + 2y^2 + e^y) \
  = (2(-1)^2 + 4(-1) + 3(-1)(0) + 2(0)^2 + e^0) \
  = 2 - 4 + 1 = -1
$
+ $ lim_((x,y) -> (0,0)) (x+1)/(x^2 + y^2); "Use polar coordinates:" \
  (x,y) -> 0 <=> ||vector(x,y)-vector(0,0)|| -> 0 \
  sqrt(x^2 + y^2) = r \
  lim_((x,y) -> (0,0)) (x+1)/(x^2 + y^2) = lim_(r->0) overbrace(r cos theta + 1, 1)/underbrace(r^2,0) = + infinity
$
+ $ lim_((x,y) -> (0,0)) (x+y)/(sqrt(x^2 + y^2)) =
  lim_(r->0)(r(cos theta + sin theta))/r = lim_(r->0) cos theta + sin theta \
  theta in RR; sin theta + cos theta > 0 \
  "limit does not exist"
$
+ $ lim_((x,y)->(0,0)) (x y)/(x^2 + y^2) \
  "Approach along x = y": 
  lim_(x->0)(x^2)/(2x^2) = 1/2 \
  "Approach along x = 0":
  lim_(y->0)(0)/(y^2) = 0 \
  "Approach along x = y^2":
  lim_(y->0)(y^3)/(y^4 + y^2) = lim_(y->0)(y)/(y^2 + 1) = 0 \
$