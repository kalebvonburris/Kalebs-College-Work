#set page(
  paper: "us-letter",
  header: align(right)[
    Kaleb Burris \
    Math 307 - Discrete Mathematics \
    Assignment 2 \
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

=== Problem 2
Let $A = {1, 2, 3}$, $B = {n in PP : n "is even"}$, and $C = {n in PP : n "is odd"}$.

a) Determine $A inter B$, $B inter C$, $B union C$, and $B plus.o C$.

$A inter B = #rect[${1,2,3,4,6,8,10,12,...}$]$

$B inter C = #rect[$emptyset$]$

$B union C = #rect[$PP$]$

$B plus.o C = #rect[$PP$]$

#v(1em)

b) List all subsets of $A$.

$P(A) = #rect[${emptyset, {1}, {2}, {3}, {1,2}, {1,3}, {2,3}, {1,2,3}}$]$

#v(1em)

c) Which of the following sets are infinite? $A plus.o B$, $A plus.o C$, $A without C$, $C without A$.

$#rect[$A without C$]$ is finite because only the given set $A$ is finite, and no other operations provided create finite sets.
$A without C = {2}$.

=== Problem 6
The following statements about sets are false. For each statement, give an example, i.e., a choice of sets, for which the statement is false. Such examples are called *counterexamples*. They are examples that are counter to, i.e., contrary to, the assertion.

a) $A union B subset.eq A inter B$ for all $A$, $B$.

Given that $A = {1, 2}$, $B = {2, 3}$:

$
  A union B & = {1, 2, 3} \
  A inter B & = {2} \
        {2} & subset.neq {1, 2, 3} \
$

#v(1em)

b) $A inter emptyset = A$ for all $A$.
$
  "If" A = {2}, "then" A inter emptyset = emptyset, "and" A != emptyset
$
#v(0.5em)

c) $A inter (B union C) = (A inter B) union C$ for all $A$, $B$, $C$.

$
  "Given" A = {1}, B = {1, 2}, C = {3}; "then"
$
$
  A inter (B union C) & = {1} inter {1, 2, 3} = {1}, "and" \
  (A inter B) union C & = ({1} inter {1, 2}) union {3} = {1} union {3} = {1, 3} \
                  {1} & != {1, 3}
$

#v(2em)

=== Problem 8
For the sets $A = {1, 3, 5, 7, 9, 11}$ and $B = {2, 3, 5, 7, 11}$, determine the following numbers.

a) $|A|$

$ |A| = #rect[6] $

#v(2em)

b) $|B|$

$
  |B| = #rect[5]
$

#v(2em)

c) $|A union B|$

$
  A union B = {1, 2, 3, 5, 7, 9, 11} \
  |A union B| = #rect[7] \
$

#v(2em)

d) $|A| + |B| - |A inter B|$

$
  6 + 5 - |{3, 5, 7, 11}| = 11 - 4 = #rect[7]
$

#v(2em)

e) Do you see a general reason why the answers to (c) and (d) have to be the same?

#rect[Not at first. But after some consideration, I visualize it as a Venn diagram where you take both circles ($A$ and $B$), intersect them, and then consider the surface area of both circles, minus the intersection area. It's notable that "surface area of both" counts the intersection twice, so subtracting it once, give you the same surface area as the union of both sets.]

#v(6em)

=== Problem 10

a) Show that relative complementation is not commutative; that is, the equality $A without B = B without A$ can fail.

$
  "Let" A = {a, b, c}, B = {a, b, d}; "then"
$
$
  A without B & = {c} \
  B without A & = {d} \
          {c} & != {d}
$

#v(2em)

b) Show that relative complementation is not associative; that is, $(A without B) without C = A without (B without C)$ can fail.

$
  "Let" A = {a, b, c, d}, B = {a, b, e}, C = {a, c, f}; "then"
$
$
             "Left side:" \
              A without B & = {c, d} \
  (A without B) without C & = {d} \
            "Right side:" \
              B without C & = {b, e} \
  A without (B without C) & = {a, c, d} \
                      {d} & != {a, c, d}
$

#v(2em)

=== Problem 12
Let $S = {0, 1, 2, 3, 4}$ and $T = {0, 2, 4}$.

a) How many ordered pairs are in $S times T$? $T times S$?

$
  "We know that" |S times T| = |S| * |T| \
  "Therefore," |S times T| = 5 * 3 = #rect[15] \
  "This is true also for" |T times S| = |T| * |S| = 3 * 5 = #rect[15] \
$

#v(0.5em)

c) List or draw the set ${(m,n) in T times S : m < n}$

$
  {(m,n) in T times S : m < n} = \
  #rect[$ {(0,1), (0,2) (0,3), (0,4), (1,2), \ (1,3), (1,4), (2,3), (2,4), (3,4)} $] \
$

#v(0.5em)

e) List or draw the set ${(m,n) in S times T : m n >= 4}$

$
  {(m,n) in T times S : m n >= 4} = \
  #rect[$ {(2,2), (2,3), (2,4), (4,1), (4,2), (4,3), (4,4)} $]
$

== Section 1.5

=== Problem 2
Consider the function $h : PP -> PP$ defined by $h(n) = |{k in NN : k | n}|$ for $n in PP$. In words, $h(n)$ is the number of divisors of $n$. Calculate $h(n)$ for $1 <= n <= 10$ and $n = 73$.

#rect[
  Effectively, we are counting the number of divisors for each number. \
  This is rather straightforward, and therefore I will the mappings for $h$ relevant to this question.
  $ h: PP & -> PP $
  #columns(2, [
    $ 1 |-> 1 $
    $ 2 |-> 2 $
    $ 3 |-> 2 $
    $ 4 |-> 3 $
    $ 5 |-> 2 $
    $ 6 |-> 4 $
    #colbreak()
    $ 7 |-> 2 $
    $ 8 |-> 4 $
    $ 9 |-> 3 $
    $ 10 |-> 4 $
    $ 73 |-> 2 $
  ])
]

#v(2em)

=== Section 1.5 Extra \# 1

Suppose that $f : ZZ -> ZZ$ by $n -> floor(n/2)$ and $g : ZZ -> ZZ$ by $n -> 3n$.
Draw portions of arrow diagrams representing each of the four functions $f$, $g$, $f ◦ g$ and
g ◦ f .

== Section 1.6

== Problem 2

Simplify

a) $n! / (n-1)!$

$
  n! / (n-1)! = (n * (n-1) * (n-2) * ..) / ((n-1) * (n-2) * (n-3) * ..) \
  = #rect[$n$]
$

b) $(n!)^2/((n+1)!(n-1)!)$

$
  (n!)^2/((n+1)!(n-1)!) \
  = (n^2 * (n-1)^2 *..)/((n+1)*n*(n-1)^2*(n-2)^2*..)
  = #rect[$ n/(n+1) $]
$

#pagebreak()

== Problem 4

Calculate

d) $display(product_(n=1)^4 (2n+1))$

$
  display(product_(n=1)^4 (2n+1)) = (2+1)(4+1)(6+1)(8+1) \
  = 3*5*7*9 = #rect[$945$]
$


e) $display(product_(j=4)^8 (j-1))$

$
  display(product_(j=4)^8 (j-1)) = (4-1)(5-1)(6-1)(7-1)(8-1) \
  = 3*4*5*6*7*8 = #rect[$20160$]
$


=== Problem 6

a) Calculate $display(sum_(k=0)^n 2^k)$ for $n = 1, 2, 3, 4$, and $5$.

$
  display(sum_(k=0)^1 2^k) = 1 + 3 = #rect[3] \
  display(sum_(k=0)^2 2^k) = 3 + 4 = #rect[7] \
  display(sum_(k=0)^3 2^k) = 7 + 9 #rect[15] \
  display(sum_(k=0)^4 2^k) = 15 + 16 #rect[31] \
  display(sum_(k=0)^5 2^k) = 31 + 32 #rect[63] \
$

#v(2em)

b) Use your answers to part (a) to guess a general formula for this sum.

$
  "The general formula to compute" display(sum_(k=0)^n 2^k) "is most likely:" \
  #rect[$2^(k+1)-1$] \
$

#v(5em)

=== Problem 10
For $n = 1, 2, 3, dots$, let $"ssq"(n) = display(sum_(i=1)^n i^2)$.

a) Calculate $"ssq"(n)$ for $n = 1, 2, 3$, and $5$.

$
  s s q(1) = 1^2 = #rect[$1$] \
  s s q(2) = 1 + 2^2 = #rect[$5$] \
  s s q(3) = 5 + 3^2 = #rect[$14$] \
  s s q(5) = 14 + 5^2 = #rect[$39$] \
$

b) Observe that $"ssq"(n+1) = "ssq"(n) + (n+1)^2$ for $n >= 1$.

As is demonstrated above with my answers to part a), or any sum over function $f$, any given $n$ is equal to $f(n) + f(n-1)$.

#v(1em)

c) It turns out that $"ssq"(73) = 132,349$. Use this to calculate $"ssq"(74)$ and $"ssq"(72)$.

$
  s s q(74) = 132,349 + (75)^2 = 132,349 + 5,625 = #rect[$137,974$] \
  s s q(72) = s s q(73) - 73^2 = 132,349 - 5,329 = #rect[$127,020$]
$

=== Extra 1

Sequence A003001 describes "the smallest number of multiplicative persistence $n$". Multiplicative persistence is an attribute of any given number in $PP$, such that you split a number into its digits, multiply them together, and apply this process to the product until the number is $<10$.

I've written a lot of code in the past around this problem and found it to be very interesting as it requires a lot of optimization and strategy, where the goal is to find a number with the highest possible multiplicative persistence. So far, only numbers with a maximum multiplicative persistence of 11 have been found, the final number in this sequence $p(n)$ being $p(11) = 277,777,788,888,899$.
