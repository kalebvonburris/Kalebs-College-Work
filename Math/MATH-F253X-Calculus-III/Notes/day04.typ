#import "template.typ": *
#set text(size: 16pt)

= Day 4 - 1/22/2024

== Determinants

Suppose we have the vectors $arrow(v) = vector(v_1, v_2)$ and $arrow(u) = vector(u_1, u_2)$.

$
  vec(u, v) = mat(delim: "|", u_1, u_2;v_1, v_2) = u_1 v_2 - v_1 u_2
$

$
  arrow(v) = vector(a, 0); u = vector(0, b) \
  mat(delim: "|", a, 0;0, b) = a b
$

Suppose $arrow(u) || arrow(v) <=> arrow(u) = k arrow(v)$ for some $k in RR$,
then 
$
  vec(arrow(u), arrow(v)) = mat(delim: "|", k v_1, k v_2;v_1, v_2) = k v_1 v_2 - v_1 k v_2 = 0
$

$
  vec(u, v + w) = vec(u, v) + vec(u, w)
$

$
  mat(delim: "|", u_1, u_2;v_1 + w_1, v_2 + w_2) &= u_1(v_2 + w_2) - u_2(v_1 + w_1) \
                                                 &= (u_1 v_2 - v_1 u_2) + (u_1 w_2 - w_1 u_2) \
                                                 &= vec(u, v) + vec(u, w)
$

$
  vec(k u, v) = k vec(u, v)
$

This is terrible.

=== Determinants in RR^3

$
  a, b, c; vec(a, b, c) = mat(delim: "|", a_1, a_2, a_3;b_1, b_2, b_3;c_1, c_2, c_3) \
  = a_1 mat(delim: "|", b_2, b_3;c_2, c_3) - a_2 mat(delim: "|", b_1, b_3;c_1, c_3) + a_3 mat(delim: "|", b_1, b_2;c_1, c_2)
$

Example: $ mat(delim: "|", 1, 2, 0;3, 1, -1;2, 0, 3) = 1 mat(delim: "|", 1, -1;0, 3) - 2 mat(delim: "|", 3, -1;2, 3) + 0 mat(delim: "|", 3, 1;2, 0) $

$
  = 3 dot 0 - 2 dot 11 + 0 = 3 - 22 = underline(-19)
$

$
  vec(a, b, c) = -vec(a, c, d)
$

== Vector Cross Product

$
  arrow(a) times arrow(b) = vector(a_2 b_3 - a_3 b_2, a_3 b_1 - a_1 b_3, a_1 b_2 - a_2 b_1) \
  (arrow(a) times arrow(b)) dot a = (a_2 b_3) a_1 + (a_3 b_1 - a_1 b_3) a_2 + (a_1 b_2 - a_2 b_1) a_3 = 0 \
  a bot b
$

$
  arrow(a) times arrow(b) = mat(delim: "|", arrow(i), arrow(j), arrow(k);a_1, a_2, a_3;b_1, b_2, b_3)
$

Properties:

$
  arrow(a) times arrow(b) = -arrow(b) times arrow(a) \ 
  k (arrow(a) arrow(b)) = k arrow(a) times arrow(b) = arrow(a) times (k arrow(b)) \
  arrow(a) times 0 = 0 \
  arrow(a) times arrow(a) = 0 \
$

Scalar Triple Product:
$
  u dot (v times w) = (u times v) dot w
$

$
  arrow(i) times arrow(j) = mat(delim: "|", arrow(i), arrow(j), arrow(k);1, 0, 0;0, 1, 0) & = 0 arrow(i) + 0 arrow(j) + 1 arrow(k) \
  arrow(i) times arrow(j) = arrow(k)                                                      & quad arrow(j) times arrow(i) = -arrow(k) \
  arrow(j) times arrow(k) = arrow(i)                                                      & quad arrow(k) times arrow(j) = -arrow(i) \
  arrow(k) times arrow(i) = arrow(j)                                                      & quad arrow(i) times arrow(k) = -arrow(j) \
$

=== Length of Cross Products

$
  ||a times b|| \
  arrow(a) = k arrow(i)
  arrow(b) = ||b|| cos theta arrow(i) + ||b|| sin theta arrow(j) \
  a times b = a times (||b|| cos theta arrow(i) + ||b|| sin theta arrow(j)) \
  ||a||arrow(i)(||b|| cos theta arrow(i) + ||b|| sin (theta) (arrow(i) times arrow(k))) \
  ||a|| ||b|| cos theta (i times i) + ||b|| ||a|| sin theta k = ||a|| ||b|| sin (theta) k
$

Find the area of the triangle: $P(1,2,0), Q(0,1,0), R(0,0,0)$

$
  A &= (a dot b dot sin theta) / 2 \
  A &= (||R Q|| dot ||R P|| dot sin (angle P R Q)) / 2 \
    &= (||arrow(R Q) times arrow(R P)||) / 2
$

$
  mat(delim: "|", i, j, k;0, 1, 0;1, 2, 0) = i mat(delim: "|", 1, 0;2, 0) - j mat(delim: "|", 0, 0;1, 0) + k mat(delim: "|", 0, 1;1, 2) \
  = i (0 - 0) - j (0 - 0) + k (0 - 1) = -k \
  (|| -k ||) / 2 = underline(1/2)
$