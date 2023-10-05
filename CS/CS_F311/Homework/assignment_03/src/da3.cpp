// da3.cpp  SKELETON
// Glenn G. Chappell
// 2023-09-21
//
// For CS 311 Fall 2023
// Source for Assignment 3 functions

#include "da3.hpp"     // For Assignment 3 prototypes & templates

#include <functional>
using std::function;


void didItThrow(const function<void()> & ff,
                bool & threw)
{
    // Attempt function ff()
    try {
        ff();
    } 
    // Catch any exceptions
    catch (...) {
        // Modify threw to be true
        threw = true;
        // Rethrow thrown exception
        throw;
    }
    // Modify threw to be false
    threw = false;
}


int gcd(int a,
        int b)
{
    // Base cases
    if (a == 0) return b;
    if (b == 0) return a;
    if (a == b) return a;

    // Recursive case
    return (gcd(a % b, b % a));
}
