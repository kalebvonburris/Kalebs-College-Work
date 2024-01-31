#import "template.typ": *

#set text(size: 16pt)

= Day 9 - 1/31/202

== Derivatives of Vector-valued Functions

$ 
  d/(d t) vector(r_1,r_2,r_3) = vector((d r_1)/(d t),(d r_2)/(d t),(d r_3)/(d t))
$

== Integrals of Vector-valued Functions

$
  integral_a^b vector(r_1,r_2,r_3) = vector(integral_a^b r_1,integral_a^b r_2,integral_a^b r_3) + arrow(c) \
  arrow(c) = vector(c_1, c_2, c_3)
$

_Quiz tomorrow is on sections 2.4 & 2.5_.

== Length and Curvature

Given the path $arrow(r)(t)$, we can find the length of a given segment from $sum ||arrow(v_k)|| Delta t$, where $lim_(t -> 0)$, $a<= t <=b$.

This goes to:

$
  integral_a^b ||arrow(v)(t)|| d t = integral_a^b sqrt(v_1^2 (t) + v_2^2 (t) + v_3^2 (t)) d t \
  ell(t) = integral_a^b ||r'(t)|| d t
$

#underline("Example:") Find the length of the helix: $ r(x) = vector(cos(t), sin(t), t); t in [0, 2 pi] \
  ell = r'(t) = vector(-sin(t), cos(t), 1) \
  ell = integral_0^(2 pi) sqrt((-sin(t))^2 + cos(t)^2 + 1^2) d t =
  integral_0^(2 pi) sqrt(1 + 1) d t = integral_0^(2 pi) sqrt(2) d t \
  = sqrt(2)t |_0^(2 pi) = 2 pi sqrt(2) - 0 = underline(2 pi sqrt(2))
$

#pagebreak()

== Length Parametrization

To derive the position from a given length along the function $arrow(r): (a,b) -> RR^3$: 
$
  s(t) integral_a^t underbrace(||r'(tau)||d tau, "length of the \n path at time t")
$

#underline("Example:") $ arrow(r) = vector(cos t, sin t); t in [0, 2 pi] \
  s(t) = integral_0^t ||arrow(r)(tau)|| d tau \
  = integral_0^t ||vector(-sin tau, cos tau)|| d tau = integral_0^t 1 d tau = t \
  s(t) = t therefore "For any time" t, "the ending position will be" t \
  s in [0, 2 pi]
$

#underline("Example:") $ arrow(r) = vector(t + 3, 2t - 4, 2t); 3 <= t \
  s(t) = integral_3^t ||r'(tau)||d tau = integral_3^t ||vector(1,2,2)||d tau \
  = integral_3^t sqrt(1^2 + 2^2 + 2^2) d tau = integral_3^t 3 d tau = 3 t - 9 = s(t) \
  t = (s(t) + 9)/3 \
  arrow(r)(s) = underline(vector(s/3 + 6, (2 s)/3 + 2, (2 s)/3 + 6))
$

#pagebreak()

== Curvature

Curvature is the derivative of your direction; how fast you turn.

