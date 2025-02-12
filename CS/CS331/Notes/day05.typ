#import "@preview/finite:0.3.0": *

#set text(size: 16pt)

= Day 5 - 1/26/2024

== Backus-Naur Form

- Nonterminals are in angle-brackets (`<>`).
- The Start symbol can vary.
- Terminals are in quotes (`""`).
- Arrow is replaced with `::=`.
- The vertical bar is the same `|`.
- Epsilon ($epsilon$) is not needed.
- Spaces are ignored.
- Each production must be on a line.

BNF for US phone number:

$
  <"phone-number"> ::= <"area-code"> <"digit"7> | <"digit"7>
$

=== EBNF

*Extended BNF* are vatiations on BNF. They typically:

- Don't use angle brackets for nonterminals.
- `::=` is replaced with `=` or `:`.
- A production can use multiple lines.
- Parentheses may be used for grouping.
- Brackets `[]` surround optional sections.
- Braces `{}` surround optional and repeatable sections.

== Lexical Structure

The lexical structure of a PL is how the program is broken down into lexems.

