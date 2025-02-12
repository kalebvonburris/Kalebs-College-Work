#import "template.typ": *
#set text(size: 16pt)

= Day 5 - 1/24/2024

== Volume of a Parallelpiped

To find the area of a parallelpiped with sides $arrow(a) arrow(b) arrow(c)$, use tthe formula $||arrow(a) times arrow(b)|| dot "proj"_(arrow(a) times arrow(b)) arrow(c)$.

== Lines in the plane

Given a line $a x + b y + c = 0$ there is a normal vector $vector(a, b)$ and a direction vector $vector(-b, a)$.

Suppose we know two points along the line; $P(q_1, q_2)$ and an arbitrary point $O$. If we look at a point on the line, $(x,y)$, then a scalar $M = arrow(O P) + alpha arrow(P Q)$.

Parametric equation of a line $l$:

$
  arrow(O P) + t arrow(P Q) = M, "where" P, Q in l 
$

$
  vector(p_1, p_2, p_3) + t vector(v_1, v_2, v_3) = vector(x,y,z)
$

$
  p + t v_1 = x \
  p + t v_2 = y \
  p + t v_3 = z \
$

Suppose $v_1, v_2, v_3 != 0$. 

$
  (x-p_1)/v_1 = (y-p_2)/v_2 = (z-p_3)/v_3 = - t\
  "Symmetric form"
$

Example: Find the equation for $P(1,2,3), vector(1,0,1)$

$
  "It's simply" arrow(P) = t arrow(v)
$

Use $P(1,2,3), Q(-2,3,0)$:

$
  "Dir. Vec": arrow(P Q) = vector(-2-1, 3-2, 0-3) = vector(-3, 1, -3) \
  (x-1)/(-3) = (y-2)/1 = (z-3)/(-3)
$

=== Finding the distance from a line to a point

Given the point $M$ and a point on the line $P$, we find the point of the line perpendicular to $M$ to be $S.$

$
  M S = P M dot sin theta \
  P Q dot M S = P Q dot P M sin theta \
  ||P Q|| dot ||M S|| = (||P Q times P M||) / (||P Q||)
$

If the line is given in the form $arrow(p) + t arrow(v)$, then $||arrow(p) + t arrow(v) - arrow(m)||$