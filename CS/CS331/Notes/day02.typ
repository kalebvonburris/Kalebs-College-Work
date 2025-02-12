#import "@preview/finite:0.3.0": *
#set text(size: 16pt)

= Day 2 - 1/19/2024

== Review

=== Formal Languages

A formal language is a set of strings. An alphabet is the set of characters that
may appear in the strings.

A language over ${0,1}$:

$ {epsilon, 01, 0101, 010101, ...} $

==== Describing

Two ways to describe a language:

+ Generator: Can produce all strings in a language
+ Recognizer: Can recognize all strings in a language

=== Grammars

A grammar is a list of one or more productions (a string substitution rule).

Example:

$
  1. quad & S -> x S y \
  2. quad & S -> a \
  3. quad & S -> epsilon \
$

==== Usage

+ Start with start symbol ($S$)
+ Apply production ($->$)
+ Go until no more _nonterminals_ (uppercase letters)

Example: derive $x x x y y y$

$
  S -> overbrace(x S y, 1) -> overbrace(x x S y y, 1) -> overbrace(x x x S y y y, 1) -> overbrace(x x x y y y, 3)
$

Example: What language does this generate? 

$
  { epsilon, "a", "xy", "xxyy", ..., "xay", "xxayy", ... }
$

Example: Based on Grammar D, write a derivation for $x y$.

#align(center)[*Grammar D*]

$
  1. quad & S -> A B \
  2. quad & A -> x \
  3. quad & B -> y \
$

$
  S -> overbrace(A B, 1) -> overbrace(x B, 2) -> overbrace(x y, 3)
$

===== Exercises

7. Write the grammar that generates the language: ${a b, a b b, a b b b, ...}$
  
  $
    1. quad & S -> a b X \
    2. quad & X -> X b \
    3. quad & X -> epsilon
  $

8. How can you rewrite the grammar from 7. to also generate the string "$a$"?
  
  Remove the $b$ from the first production.

== The Chomsky Hierarchy

Includes 4 nested categories of languages, types 3, 2, 1, and 0.

=== Regular Language

A regular language is one that can generated with a grammar that has one of:

$
  1. quad & A -> epsilon \
  2. quad & A -> b \
  3. quad & A -> b C
$

=== Context-Free Language

A context-free language is one that can be generated from a grammar where each
left-hand production consists of a single nonterminal.

$
  n. quad & A -> ["anything"]
$

=== Context-Sensitive Language

We don't care about context-sensitive languages.

=== Computably Enumerable Language

A computably enumerable language is one that can be described by a grammar.

The recognizer is a *Turing machine*.

=== Regular Languages

Regular languages have two important applications:

+ In most PLs, the set of all lexems of a particular kind forms a regular
  language.
+ He skipped the rest of the slide.

==== Grammar

As stated above:

$
  1. quad & A -> epsilon \
  2. quad & A -> b \
  3. quad & A -> b C
$

Here's an example:

$
  1. quad & S -> epsilon \
  2. quad & S -> t \
  3. quad & S x B \
  4. quad & B y S \
$

What language does this grammar generate?

$
  {epsilon, t, x y t, ...}
$

More examples occurred.

== Finite Automata

A deterministic finite automata (DFA) is a kind of recognizer for regular
languages.

A DFA consists of a bunch of states and a translation between those states.

#align(
  center,
)[
  #automaton(
    layout: layout.circular, (A: (B: "a", A: "b", C: "a"), B: (B: "a,b", C: "a"), C: (C: "b")),
  )
]

Incredible, I know.

Languages that are recognized by DFAs are regular languages.

Exercise: I won't draw the diagram but what language is recognized by it?

$
  {y, y y, y y y, ..., x x, x x x x, x x x x x x, ..., x y x, x y x y, x x y x x, x x y x x y, ...}
$

*0 is an even number*


