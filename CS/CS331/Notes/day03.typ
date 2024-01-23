#import "@preview/finite:0.3.0": *

#set text(size: 16pt)

= Day 3 - 1/22/2024

== Regular Expressions - _Regex_

*Synatx* is about correct structure. 

*Semantics* is about what something means

=== Arithematic Expressions

First, the pieces:

- A numberic literal: 26.5, 1, 100000
- An identifier (variable): $x$, $x$, $z$

Then the slides went too fast.

=== Examples

What language does this regex generate: $(a|x)^* c b$

$
  underline({c b, a^n x^m c b})
$

What language does this regex generate: $(x y)^* (|t)$

$
  {epsilon, (x y)^n | t}
$

Write a regex to generate: ${y, x y, x x y, x x x y, ..., z, x z, x x z, x x x z}$

$
  x^* (y|z)
$


Draw the DFA diagram for the previous language:

#align(center)[
  #automaton((A: (B: "y,z", A: "x"), B: (C: "x,y,z"), C: (C: "x,y,z")))
]

Imagine $B$ is an accepting state.

=== In Practice

We end up with cumbersome regex statements ($(1|2|3|4|5|6|7|8|9|0)$). 

Regex libraries are available and offer many QOL shortcuts.

First, "." matches any character.

Second, brackets with a list of chars between them will match any one of the
chars in the list: $[q w e r t y] <=> [q|w|e|r|t|y]$.

Using a "-" specifies a range of consecutive characters.

The following will match any single ASCII letter: $[A-Z a-z]$.

"+" means one or more, the same how "\*" means one or more: $a b c + <=> (a b c)^*$

"?" means zero or one - optional. $x(a b c)? <=> x | x a b c$

"\\" escapes a special character. "\\\\" escapes backslash, "\\." specifies just ".".