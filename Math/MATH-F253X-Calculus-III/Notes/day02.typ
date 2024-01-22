#import "template.typ": *
#set text(size: 16pt)

= Day 2 - 1/18/2024

== Unit Vectors

Vectors $arrow(i) = vector(1, 0)$ and $arrow(j) = vector(0, 1)$ both have the same
length of $||arrow(i)|| = ||arrow(j)|| = 1$

=== Finding the Unit Vector of $arrow(v)$

We can find the unit vector in the direction of $arrow(v)$ by dividing $arrow(v)$ by
its magnitude.

Example:

$
  arrow(v) = vector(3, 4), "Unit vector of" arrow(v) "is:" \
  ||arrow(v)|| = sqrt(3^2+4^2) = 5 \
  ||arrow(v)|| = arrow(v)/5 = vector(3, 4)/5 = underline(vector(3/5, 4/5))
$

== Vector from Angle $alpha$

Given an angle $alpha = pi/3$ and a length of the vector $arrow(v)$, $||arrow(v)|| = 3$,
we can use trigonometric identities to determine $arrow(v)$.

The unit vector of $arrow(v)$ will necessarily be defined as $vector(cos(alpha), sin(alpha))$,
we can then define the vector from before to be $arrow(v) = vector(||arrow(v)||cos(alpha), ||arrow(v)||sin(a))$.
We can solve this to find $arrow(v)$:

$
  arrow(v) = vector(3cos(pi/3), 3sin(pi/3)) = underline(vector(3/2, (3sqrt(3))/2))
$

== Examples of Vector-Valued Quantities

- Newtons ($N$ = $"kg"dot"m"/"s"^2$)
- Velocity ($"m"/"s"$)
- Acceleration ($"m"/"s"^2$)
- Position ($"m"$)

== 3-Dimensional Vectors

3-Dimensional vectors contain an extra _z_ component, making them defined as $vector(x, y, z)$.

=== $x y$ Planes

An important concept is the $x y$ plane, a 2-dimensional slice along the $z$ axis
in a 3-dimensional space. 

For any given plane will have the plane $P(x,y,z)$:

$
  "yz plane" &<=> x=0\
  "xy"       &<=> z=9\
  "zx"       &<=> y=0
$

For any given 3 points there is a plane. For example:

The three points $(1,2,3)$, $(-4,4,3)$, and $(-5.3.3)$:

$
  "Note that all points have" z = 0, therefore z=0 \
  z = 0 "is the equation for a plane that contains these points"
$

=== Length

The length of a 3-dimensional vector $arrow(P Q)$ is defined as: $ sqrt((P_x-Q_x)^2+(P_y-Q_y)^2+(P_z-Q_z)^2) $

=== Midpoints

The midpoint of a _vector_ $arrow(v)$ is defined as: $ arrow(v)/2 $

The midpoint of any segment $P Q$ is defined as: $ ((P_x + Q_x)/2, (P_y + Q_y)/2, (P_z + Q_z)/2) $

