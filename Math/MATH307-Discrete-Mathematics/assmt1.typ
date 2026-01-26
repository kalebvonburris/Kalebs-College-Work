#set page(
  paper: "us-letter",
  header: align(right)[
    Kaleb Burris \
    Math 307 - Discrete Mathematics \
    Assignment 1 \
    #line(length: 100%)
  ],
  numbering: "1",
  margin: (
    top: 1.5in,
    bottom: 1in,
    x: 0.75in,
  ),
  columns: 2,
)

#set par(justify: true)

#set text(
  size: 10pt,
)

== Homework Problems

== Section 1.1

=== Problem 4

a. $ceil(0.763) = #rect[1]$

b. $2 ceil(0.6) - ceil(1.2) = 1 - 2 = #rect[-1]$

c. $ceil(1.1) + ceil(3.3) = 2 + 4 = #rect[6]$

d. $ceil(sqrt(3)) - floor(sqrt(3)) = 2 - 1 = #rect[1]$

e. $ceil(-73) - floor(-73) = -73 - (-73) = -73 + 73 = #rect[0]$

=== Problem 8
How many multiples of 10 are there between the following pairs of numbers?

This can be solved for any pair $n, m$ such that $m <= n$ using the formula:

$
  floor(n/10) - floor((m-1)/10)
$

a. $m = 1, n = 80$

$
  floor(80/10) - floor((1-1)/10) = 8 - 0 = #rect[8]
$

b. $m = 0, n = 100$

$
  floor(100/10) - floor((0-1)/10) = 10 - (-1) = #rect[11] \
  #text[Note that 0 is a multiple of every integer \ including 10, so it is included in this count.]
$

c. $m = 9, n = 2967$

$
  floor(2967/10) - floor((9-1)/10) = 296 - 0 = #rect[296]
$

d. $m = -6, n = 34$

$
  floor(34/10) - floor((-6-1)/10) = 3 - (-1) = #rect[4]
$

e. $m = 10^4, n = 10^5$

$
  floor(10^5/10) - floor((10^4-1)/10) = 10000 - 999 = #rect[9001]
$

\ \

=== Problem 18

a. Fact 4 states that between any number $n$ and $k$ there are $floor(n/k)$ multiples of $k$ between 1 and $n$.
Therefore, in the case $k = 1$, there are $n$ positive integers between $1$ and $n$. In effect, the count of numbers between 1 and
any positive integer $n$ is simply $n$. This is obvious as any given count of a collection of size $n$ is the value of $n$ elements.

b. Given fact 4 once more, if $k > n$, then any two given numbers of $k$ and $n$ will result in $floor(n/k) = 0$ multiples of $k$ between 1 and $n$.
This is again obvious as a number greater than another given number cannot evenly divide it into an integer value $>= 1$.

=== Problem 19

a. $ "Let" x = 0.5, y = 0.5.
"Then" floor(0.5) + floor(0.5) < floor(0.5 + 0.5) \
0 + 0 < floor(1) -> 0 < 1 \
"Therefore the inequality holds for" y = 0.5, x = 0.5 $

b. $ "Let" x = 0, y = 0.
"Then" floor(0) + floor(0) = floor(0 + 0) \
0 + 0 = floor(0) -> 0 = 0 \
"Therefore the equality holds for" y = 0, x = 0 $

c. All floor operations round down to the nearest integer. Any given pair, $x, y$ must either contain
integers or non-integers. If both are integers, then the equation $floor(x) + floor(y)$ simplifies always to
$x + y$. In any case for $x, y$ that at least one is a non-integer, the floor operator will reduce that value such that $floor(x) < x$ and/or $floor(y) < y$. Therefore, $floor(x) + floor(y) <= x + y$.

We know that $floor(x + y)$ is the largest integer less than or equal to $x + y$ and that $floor(x) + floor(y)$ is an integer.

Given these facts, $floor(x) + floor(y)$ must also always be less than or equal to $floor(x + y)$.

#pagebreak()

== Section 1.2

=== Problem 12

No, two different even integers cannot be relatively prime. We define a given integer $n$ to be even if $2|n$. Any given pair of even integers $n, m$ can be expressed as $n = 2k$ and $m = 2j$ for some integers $k, j$. The factor 2 in these equations would be a common factor that is not 1, so the two even integers cannot be relatively prime.

=== Problem 14

a. We can expand the expression $l m$ into the expression $a d l$. We can then very clearly see that both $d$ and $a d l$ share the common factor $d$. Therefore, in any case where $l$ is an integer, $m l$ is evenly divided by $d$, thus $d | m l$.

b. In both cases, we can factor out $d$, which inherently defines the operations as factors of $d$.

$
  m + n = a d + b d = d(a + b) \
  m - n = a d - b d = d(a - b) \
$

c. We can see that $17m - 72n = 17a d - 72b d = d(17a - 72b)$ As both $a$ and $b$ are integers, so must $17a - 72b$. Therefore, $d$ divides $17m - 72n$.

=== Problem 16 b.

The factors of 36 are: 1, 2, 3, 4, 6, 9, 12, 18, 36. All numbers not sharing these factors are therefore relatively prime (except for sharing 1). Those are: 1, 5, 7, 11, 13, 17, 19, 23, 25, 29, 31, and 35.

== Section 1.3

=== Problem 2

List the elements (${}$) in the following sets:

a. $ { 1/n : n = 1, 2, 3, 4 } = { 1, 1/2, 1/3, 1/4 } $

b. $ { n^2 - n: n = 0, 1, 2, 3, 4 } = { 0, 0, 2, 6, 12 } $

c. $ { 1/2^2: n in bb(P), n "is even and" n < 11 } = { 1/4, 1/16, 1/36, 1/64, 1/100 } $

#v(10%)

d. $ { 2 + (-1)^n : n in bb(N) } = { 3, 1, 3, 1, .. } "or simply" { 3, 1 } $

=== Problem 6

Repeat Exercise 4 for the following sets (determine the following sets):

a. $ { n in bb(N): n|12 } = { 1, 2, 3, 4, 6, 12 } $

b. $ { n in bb(N): n^2 + 1 = 0 } = cancel(O) \
"as all values of" n "result in" n^2 + 1 > 0 $

c. $ { n in bb(N): floor(n/3) = 8 } = { 24, 25, 26 } $

d. $ { n in bb(N): ceil(n/2) = 8} = { 15, 16 } $

== Problem 8

How many elements are in the following sets? Write $infinity$ if the set is infinite.

a. $ { n in bb(N): n^2 = 2 }: #rect[$cancel(O)$] "as no integer" k "exists such that" \
sqrt(2) = k "and" k in bb(N) "as" sqrt(2) approx 1.41 $

b. $ { n in bb(Z): 0 <= n <= 73 }: (73 - 0) + 1 = #rect[74] $

c. $ { n in bb(Z): 5 <= abs(n) <= 73 }: (73 - 5) + 1 - (5 - 73) + 1 \ = 68 - (-68) + 2 = 136 + 1 = #rect[138] $

d. $ { n in bb(Z): 5 < n < 73 }: 73 - 5 - 1 = #rect[67] $

#pagebreak()

#set page(columns: 1)

e. $ { n in bb(Z): n "is even and" abs(n) <= 73 }: \
"Using the formula defined in worksheet 1 to determine" \
"all even numbers between" m "and" n: floor(n/2) - floor((m-1)/2) \
floor(73/2) - floor((0-1)/2) = 36 - 0 = 36 \
abs(n) "includes negative even integers as well, thus" 36 * 2 = 72 \
"Including" 0 "as an even integer gives a final total of" 72 + 1 = #rect[73] \ $

f. $ { x in bb(Q): 0 <= x <= 73 }: #rect[$infinity$], "as there are infinite rational" \
"numbers between any two given integers." $

g. $ { x in bb(Q): x^2 = 2 }: #rect[0] "as there is no number defined as" \
m in bb(Z), n in bb(Z) "such that" (m/n)^2 = 2 "or" m/n = sqrt(2), "because" sqrt(2) "is irrational." $

h. $ { x in bb(R) x^2 = 2 }: #rect[2], "we defined before that the number" sqrt(2) "satisfies this condition." \
bb(R) "includes irrational numbers whereas" bb(Q) "does not, allowing for" sqrt(2). \
"Additionally," -sqrt(2) "also satisfies this condition as" (-sqrt(2))^2 = 2, "making the set be" { -sqrt(2), sqrt(2) } $
