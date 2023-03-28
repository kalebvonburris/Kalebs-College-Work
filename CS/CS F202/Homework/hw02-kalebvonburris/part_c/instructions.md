# HW02 - Part C (13%)

Part C of [this assignment](../README.md) provides you with an opportunity to demonstrate a satisfactory understanding of the contents from [Chapters 10 and 11 of Programming Principles and Practice using C++][textbook].


### What you should do

In this subdirectory:

Create a file called part_c.cpp that contains a main function `int main(int argc, char * * argv) { ... }`. Within `main`:

* Create a `string` variable called `program_name` that is initialized to the value of the program. Hint: get this from `argv[0]`
* If the user did not provide a filename as an argument, print a usage message to `std::cerr` and return 1
* Otherwise, create a `string` variable called `input_filename` that is initialized to the value of the filename provided by the user. Hint: get this from `argv[1]`
* Treat the user-provided argument provided by the user as an input file name (consisting of floating point numbers separated by whitespace)
* Using `ifstream` and `cout`, read the contents of the input file one token at a time using `>>`, writing each number to its own line using `cout`. The `cout` stream must be configured such that each floating point number will be printed using only 2 digits after the decimal point (see `std::fixed` and `std::setprecision`)


### What the results should look like

A successful run of the program should look like this:
<pre>$ ./part_c ; echo "Return value is $?"
Usage: ./part_c input.txt
Return value is 1
</pre>


<pre>$ ./part_c input.txt
3.14
100.00
-1.01
1.00
1.11
10.00
</pre>




### Minimum criteria required for code to be graded

To earn any credit for Part C, the following criteria must be met:
* Your code must be correctly pushed to the **main** branch of your HW02 Github repository
* You must have a file called `part_c.cpp` located in the `part_c` subdirectory
* The file `part_c.cpp` must cleanly compile on `aurora` with no errors or warnings with the command: `g++ -std=c++17 -o part_c part_c.cpp`

If either of these criteria are not met, your code will not be graded and you will receive zero credit for Part C.




### What does it mean if I successfully complete this part of the assignment?

In conjunction with Part D, Part C of this assignment is designed to assess satisfactory understanding of the content from [Programming Principles and Practice using C++][textbook].

The term **satisfactory understanding** is used in the description of the [UAF grading system](https://catalog.uaf.edu/academics-regulations/grading-system-gpa-computation).




[textbook]: https://learning.oreilly.com/library/view/programming-principles-and/9780133796759/ch10.xhtml#ch10

