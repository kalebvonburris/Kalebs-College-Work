// da3.hpp  SKELETON
// Glenn G. Chappell
// 2023-09-21
//
// For CS 311 Fall 2023
// Header for Assignment 3 functions

#ifndef FILE_DA3_HPP_INCLUDED
#define FILE_DA3_HPP_INCLUDED

#include "llnode.hpp"  // For LLNode
#include <cstddef>     // For std::size_t
#include <functional>  // For std::function
#include <stdexcept>   // For std::out_of_range


template <typename ValueType>
ValueType lookup(const LLNode<ValueType> * head,
                 std::size_t index)
{
    const LLNode<ValueType> * ptr = head;

    // March through the list and bounce out if necessary
    for (int i = 0; ptr != nullptr && i < index; i++, ptr = ptr->_next) {/* No code needed */}

    // Throw an error if we went out of range
    if (ptr == nullptr) throw std::out_of_range("Index given is out of range.");

    // Return back the data at index
    return ptr->_data;
}


// Implementation in source file
void didItThrow(const std::function<void()> & ff,
                bool & threw);


template <typename FDIter>
bool checkSorted(FDIter first,
                 FDIter last)
{
    // Loop through entire list
    while (first != last) {
        // Verify each element is sorted
        if (*last < *first) return false;
        // Move to next item
        first = first++;
    }
    // Return true if elements are sorted
    return true;
}


// Implementation in source file
int gcd(int a,
        int b);


#endif  //#ifndef FILE_DA3_HPP_INCLUDED
