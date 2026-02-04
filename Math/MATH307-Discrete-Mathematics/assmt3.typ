#set page(
  paper: "us-letter",
  header: align(right)[
    Kaleb Burris \
    Math 307 - Discrete Mathematics \
    Assignment 3 \
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

=== Section 1.7

=== Problem 4

Consider the following functions from $NN$ into $NN$:
$1_NN (n) = n$, $f(n) = 3n$, $g(n) = n + (-1)^n$, $h(n) = min[n, 100]$, $k(n) = max[0, n - 5]$.

a) Which of these functions are one-to-one?

#rect[
  The functions $1_(NN)$, $f$, and $g$.

  In the case of $1_(NN)$, the function simply maps any $n$ to itself, and thus cannot map it to another number.

  In the case of $f$, the logic is the same as $1_(NN)$, just that the values being mapped to are tripled.

  In the case of $g$, we get an odd pattern such that ${g(0), g(1), g(2), g(3), g(4), g(5), .. } = { 1, 0, 3, 2, 5, 4, .. }$
  We can see a pattern here that we swap every pair of numbers such that ${0,1,2,3,4,5} = {1,0,3,2,5,4}$. With this mapping, $g$ is therefore one-to-one.
]

#v(2em)

b) Which of these functions map $NN$ onto $NN$?

#rect[
  The functions $1_(NN)$, $g$, and $k$ map $NN$ onto $NN$.

  The case for $1_(NN)$ is trivial as explained in my answer for `4a`, $1_(NN)$ maps any given $n$  to itself, and thus is onto.

  In the case of $g$, since $g$ merely swaps neighboring pairs, it also is onto as it maps every possible output with an input $n$.

  In the case of $k$, this function would provide an issue if $NN$ did not include $0$. However, the $max$ function in this case maps all inputs $n <= 5$ to $0$, and all inputs $n > 5$ to $n-5$. This still maps them to every possible value in $NN$, making it onto.
]

#v(8em)

=== Problem 5cde

Here are two "shift functions" mapping $NN$ into $NN$:
$f(n) = n + 1$ and $g(n) = max[0, n - 1]$ for $n in NN$.

c) Show that $f$ is one-to-one but does not map $NN$ onto $NN$.

#rect[
  $f$ is one-to-one because $f$ maps all $n$ to $n + 1$, thus never mapping any two $n$ to the same output.

  $f$ is not onto as all $f(n) >= 1$. $0 in NN$ and not the range of $f$, thus making it not onto.
]

#v(2em)

d) Show that $g$ maps $NN$ onto $NN$ but is not one-to-one.

#rect[
  $g$ maps $NN$ onto $NN$ because the range of $g$ is ${0, 1, 2, 3, 4, ..}$. We can see that by computing $g$:
  $
    g(0) & = max[0, 0 - 1] = max[0, -1] = 0 \
    g(1) & = max[0, 1 - 1] = max[0, 0] = 0 \
    g(2) & = max[0, 2 - 1] = max[0, 1] = 1 \
    g(3) & = max[0, 3 - 1] = max[0, 2] = 2 \
         & dots.v
  $
  $g$ merely maps the first two elements of $NN$ to 0 and then to $n - 1$. This also makes it not one-to-one as two input elements, (0 and 1) both map to 0.
]

#v(2em)

e) Show that $g compose f(n) = n$ for all $n$, but that $f compose g(n) = n$ does not hold for all $n$.

#rect[
  $
    g compose f(n) = g(n + 1) \
    = max[0, n + 1 -1] = max[0, n]; \
    max[0, n] = n "as" min(NN) = 0.
  $
  #h(100%)
  $
    f compose g(n) = g(max[0, n - 1]) \
    = max[0, n - 1] + 1; \
    g(f(0)) = max[0, 0 - 1] + 1 = 1. 0 != 1 \
    "therefore" f compose g(n) != n
  $
]

#pagebreak()

=== Problem 6bc
Let $Sigma = {a, b, c}$ and let $Sigma^*$ be the set of all words $w$ using letters from $Sigma$; see Example 2(b). Define $L(w) = "length"(w)$ for all $w in Sigma^*$.

b) Is $L$ a one-to-one function? Explain.

#rect[
  No. $L$ maps $Sigma^* -> NN$ by the length of any word definable with $Sigma$. We can see though that the words "$a$" and "$b$" both have length 1, or $L("\"a\"") = 1, L("\"b\"") = 1$, which makes this function not one-to-one.
]

#v(2em)

c) The function $L$ maps $Sigma^*$ into $NN$. Does $L$ map $Sigma^*$ onto $NN$? Explain.

#rect[
  Yes, $L$ does map $Sigma^*$ onto $NN$, as any given word in $Sigma^*$ can be of any possible length $>=0$. Any word can have any number of letters, but also $epsilon in Sigma^*$, satisfying the needed $L(n) = 0$.
]

=== Problem 11
Here are some functions from $NN times NN$ to $NN$: $"SUM"(m,n) = m + n$, $"PROD"(m,n) = m * n$, $"MAX"(m,n) = max[m,n]$, $"MIN"(m,n) = min[m,n]$; here $*$ denotes multiplication of integers.

a) Which of these functions map $NN times NN$ onto $NN$?

#rect[
  All functions here map $NN times NN$ onto $NN$.

  $
     "For SUM": & "SUM"(0,n) = n \
    "For PROD": & "PROD"(1,n) = n \
     "For MIN": & "MIN"(n,n) = n \
     "For MAX": & "MAX"(0,n) = n
  $
]

#v(2em)

b) Show that none of these functions are one-to-one.

#rect[
  $
     "For SUM": & "SUM"(0,1) = 1 "and" "SUM"(1,0) = 1 \
    "For PROD": & "PROD"(2,3) = 6 "and" "PROD"(3,2) = 6 \
     "For MIN": & "MIN"(0, 1) = 0 "and" "MIN"(1,0) = 0 \
     "For MAX": & "MAX"(0,1) = 1 "and" "MAX"(1,0) = 1
  $
]

#v(3em)

c) For each of these functions $F$, how big is the set $F^(<-)(4)$?

#rect[
  For SUM: Find all pairs where $m + n = 4$:

  $ |{(0,4), (1,3), (2,2), (3,1), (4,0)}| = 5 $


  For PROD: Find all pairs where $m times n = 4$

  $ |{(1,4), (2,2), (4,1)}| = 3 $

  For MIN: Find all pairs where $min[m,n] = 4$

  $ |{(4,4), (4,5), (4,6), .., (5,4), (6,4), ..}| = infinity $

  #h(100%)

  For MAX: Find all pairs where $max[m,n] = 4$

  $ |{(0,4), (1,4), (2,4), (3,4), (4,4), \ (4,0), (4,1), (4,2), (4,3)}| = 9 $
]

#v(2em)



