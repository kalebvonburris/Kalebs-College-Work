﻿// Class FSArray
// Kaleb Burris
// 9-21-2023
// A class that stores arbitrary T elements for CS311 Assignment 2.

#pragma once

#include <string>
// For strings
#include <cstddef>
// For size_t
#include <cassert>
// For assert()


// Invariants: None
template <typename T>
class FSArray {
public:
// ***** FSArray: Types *****
public:
    using value_type = T;
    using size_type = std::size_t;


// ***** FSArray: Ctors, dctor *****
public:
    // Default Ctor.
    // Creates a new instance an array of 8 elements.
    FSArray() : 
    _array_ptr(new value_type[8]), 
    _array_size(8)
     {}

    // 1 Parameter Ctor.
    // Takes explicitly a size_type parameter.
    explicit FSArray(size_type size) : 
    _array_ptr(new value_type[size]),
    _array_size(size)
    {}

    // 2 Parameter Ctor.
    // Takes explicitly a size_type parameter and a 
    //     value_type parameter that it will copy into 
    //     an array `size` many times.
    explicit FSArray(size_type size, value_type val) :
    _array_ptr(new value_type[size]),
    _array_size(size)   
    {
        for (size_type i = 0; i < size; i++)
            this->_array_ptr[i] = val;
    }

    // Dctor.
    ~FSArray() {
        delete [] _array_ptr;
    }

// ***** FSArray: General public operators *****
public:
    // op[] - non-const & const
    // Parameter index must be in the range [0, size), where size is the
    // parameter passed to the ctor.
    value_type & operator[](size_type index) {
        assert(index >= 0 && index <= size());
        return _array_ptr[index];
    }
    const value_type & operator[](size_type index) const {
        assert(index >= 0 && index <= size());
        return _array_ptr[index];
    }

    // op== - const
    // The given FSArray must have the same
    //     `type_value` as the one it's being
    //     compared against.
    bool operator==(const FSArray<T> other) const {
        if (this->size() != other.size()) return false;

        for (size_type i = 0; i < size(); i++)
            if (_array_ptr[i] != other.begin()[i]) return false;

        return true;
    }

    // op!= - const
    // The given FSArray must have the same
    //     `type_value` as the one it's being
    //     compared against.
    bool operator!=(const FSArray<T> other) const {
        return !(*this == other);
    }



// ***** FSArray: General public member functions *****
    // size() - const
    // Returns the size of the array.
    size_type size() const { return _array_size; }

    // begin() - const & non-const
    // Returns the address of the first element in the array.
    value_type* begin() { return _array_ptr; }
    const value_type* begin() const { return _array_ptr; }

    // end() - const & non-const
    // Returns the address of the last element in the array.
    value_type* end() { return _array_ptr + _array_size; }    
    const value_type* end() const { return _array_ptr + _array_size; }

private:
    // The pointer to the beginning of the array.
    value_type* _array_ptr;

    // The size of the array.
    size_type _array_size;

}; // End of class FSArray