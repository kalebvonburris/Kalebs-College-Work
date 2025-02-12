#import "template.typ": *
#set text(size: 16pt)

= Day 1 - 1/17/2024

== Vectors in $RR^2$

Defined as a directed segment, $arrow(A B)$. Similar vectors that are the same
when translated onto each other are denoted to be equivalent with $equiv$. 

Vectors with initial point $P$ and terminal point $Q$ are standardized by moving $P$ to
the origin and keeing $Q$ relative to $P$.

For $P = (0,0)$ and $Q = (3,3)$, we define $arrow(A B) = vector(3, 3)$,
therefore $arrow(A B) = vector(x_B - x_A, y_B - y_A)$

For any 2 vectors $arrow(A B)$ and $arrow(C D)$, we can find that $arrow(A B) + arrow(C D) = arrow(C D) + arrow(A B)$.

Any vector $arrow(A A)$ is defined to be directionless and without length.

=== Vector Multiplication

Scalars - A number.

We define a scalar multiplication with the scalar $k$ to be $2 A B = vector(k dot (x_B - x_A), k dot (y_B - y_A))$.

Notibly, a scalar multiplication with the scalar $k$ will adjust the length of a
vector $v$ to be $k dot v$.

$k v$ has length $|k| ||v||$.

Scalars can be negative, reversing a vector $arrow(A B)$ to be $arrow(B A)$,
inverting its _direction_.

=== Vector Subtraction

Defined as $v - u = v + (-1)u$

Incredible. Just awesome. Nobody is passing this class.

==== Example

Define $v - u$.

$
  P(1,2)\
  Q(2,1)\
  A(0,2)\
  B(2,2)\
  arrow(v) = arrow(P Q), quad arrow(w) = arrow(A B)\
  arrow(u) = 2 arrow(v) - arrow(w)\
  arrow(v) = vector(2-1, 1-2) = vector(1, -1)\
  arrow(w) = vector(2-0, 2-2) = vector(2, 0)\
  arrow(u) &= 2 vector(1, -1) + -1 vector(2, 0)\
  arrow(u) &= vector(2, -2) + vector(-2, 0)\
  arrow(u) &= vector(0, -2)
$

== Vector Magnitude

$arrow(v) = vector(a, b)$

How do we find the magnitude/normal/length of $arrow(v)$?

Magnitude of $arrow(v)$: $||arrow(v)|| = sqrt(a^2 + b^2)$.

== Unit Circle

We define $arrow(i)$ to be $vector(1, 0)$ and $arrow(j)$ to be $vector(0, 1)$.