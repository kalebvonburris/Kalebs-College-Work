# HW02 - Part D (61%)

Part D of [this assignment](../README.md) provides you with an opportunity to demonstrate basic understanding of the contents from [Chapters 10 and 11 of Programming Principles and Practice using C++][textbook].

### What you should do

In this subdirectory:

Create a file called part_d.cpp that contains a main function `int main(int argc, char * * argv) { ... }`. Within `main`:

* Create a `string` variable called `program_name` that is initialized to the value of the program. Hint: get this from `argv[0]`
* If the user did not provide a filename as an argument, print a usage message to `std::cerr` and return 1
* Otherwise, create a `string` variable called `input_filename` that is initialized to the value of the filename provided by the user. Hint: get this from `argv[1]`
* Treat the user-provided argument provided by the user as an input file name (consisting of floating point numbers separated by whitespace)
* Using `ifstream` and `cout`, read the contents of the input file one token at a time using `>>`, writing each number to its own line using `cout`


### What the results should look like

A successful run of the program should look like this:
<pre>$ ./part_d ; echo "Return value is $?"
Usage: ./part_d input.txt
Return value is 1
</pre>

<pre>$ ./part_d input.txt
3.1415
99.999
-1.00999
1.00007
1.11111
9.99999
</pre>




Your prompts should exactly match those shown above, and the format of your response to the user should exactly match that shown above.

### Minimum criteria required for code to be graded

To earn any credit for Part D, the following criteria must be met:
* Your code must be correctly pushed to the **main** branch of your HW02 Github repository
* You must have a file called `part_d.cpp` located in the `part_d` subdirectory
* The file `part_d.cpp` must cleanly compile on `aurora` with no errors or warnings with the command: `g++ -std=c++17 -o part_d part_d.cpp`


If either of these criteria are not met, your code will not be graded and you will receive zero credit for Part D.



### What does it mean if I successfully complete this part of the assignment?

Part D of this assignment is designed to assess minimal understanding of the content from [Programming Principles and Practice using C++][textbook].

The term **minimal understanding** is used in the description of the [UAF grading system](https://catalog.uaf.edu/academics-regulations/grading-system-gpa-computation).




[textbook]: https://learning.oreilly.com/library/view/programming-principles-and/9780133796759/ch10.xhtml#ch10

