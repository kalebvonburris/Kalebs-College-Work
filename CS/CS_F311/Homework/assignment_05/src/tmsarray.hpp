// TMSArray.hpp  HAND-OFF
// VERSION 6
// Glenn G. Chappell
// Started: 2023-10-17
// Updated: 2023-10-25
//
// For CS 311 Fall 2023
// Header for class TMSArray
// Marvelously smart array of int
// Preliminary to Assignment 5

// History:
// - v1:
//   - Bare-bones only, does not compile. Header & source files,
//     #ifndef, #include, empty class definition.
// - v2:
//   - Add member types value_type, size_type, iterator, const_iterator.
//   - Add dummy versions (at least) of all member functions, including
//     dummy return statements for non-void functions. Package compiles.
//   - Add data members.
//   - Add class invariants.
//   - Write (untested versions of) the following member functions:
//     default ctor, ctor from size (these two are single func), dctor,
//     op[], size, empty, begin, end, push_back, pop_back.
// - v3:
//   - Document exception-safety guarantees for most functions.
//   - Write copy ctor.
// - v4:
//   - Revise class invariants to allow for _data being nullptr if _size
//     is zero.
//   - Revise ctor from size, copy ctor accordingly.
//   - Write move ctor.
//   - Mark various functions as noexcept.
// - v5:
//   - Move func defs to source file: copy & move ops, resize, insert,
//     erase, swap.
// - v6:
//   - Add _capacity data member.
//   - Revise class invariants & ctors accordingly.
//   - Add constant DEFAULT_CAP and use it in setting the capacity in
//     default ctor/ctor from size.

#ifndef FILE_TMSArray_HPP_INCLUDED
#define FILE_TMSArray_HPP_INCLUDED

#include <cstddef>
// For std::size_t
#include <algorithm>
// For std::max
#include <cassert>
// For assert


// *********************************************************************
// class TMSArray - Class definition
// *********************************************************************


// class TMSArray
// Marvelously Smart Array of int.
// Resizable, copyable/movable, exception-safe.
// Invariants:
//     0 <= _size <= _capacity.
//     _data points to an array of value_type, allocated with new [],
//      owned by *this, holding _capacity value_type values -- UNLESS
//      _capacity == 0, in which case _data may be nullptr.

template <typename T>
class TMSArray {

// ***** TMSArray: types *****
public:

    // value_type: type of data items
    using value_type = T;

    // size_type: type of sizes & indices
    using size_type = std::size_t;

    // iterator, const_iterator: random-access iterator types
    using iterator = value_type *;
    using const_iterator = const value_type *;

// ***** TMSArray: internal-use constants *****
private:

    // Capacity of default-constructed object
    enum { DEFAULT_CAP = 42 };

// ***** TMSArray: ctors, op=, dctor *****
public:

    // Default ctor & ctor from size
    // Strong Guarantee
    explicit TMSArray(size_type thesize=0)
        :_capacity(std::max(thesize, size_type(DEFAULT_CAP))),
            // _capacity must be declared before _data
         _size(thesize),
         _data(_capacity == 0 ? nullptr
                              : new value_type[_capacity])
    {}

    // Copy ctor
    // Strong Guarantee
    TMSArray(const TMSArray & other)
    : _capacity(other._capacity),
      _size(other.size()),
      _data(new value_type[other._capacity])
    {
        for (size_type i = 0; i < other.size(); i++) {
            this->_data[i] = other[i];
        }
    }

    // Move ctor
    // No-Throw Guarantee
    TMSArray(TMSArray && other) noexcept
    : _capacity(other._capacity),
      _size(other.size())
    {
        // Move the pointer to our new array
        this->_data = other._data;
        // Clear the data of the old array
        other._size = 0;
        other._capacity = 0;
        other._data = nullptr;
    }

    // Copy assignment operator
    // Strong Guarantee
    TMSArray & operator=(const TMSArray & other) {
        // Copy size data and array capacity
        this->_capacity = other._capacity;
        this->_size = other._size;
        this->_data = new value_type[other._capacity];
        // Copy each element over
        for (size_type i = 0; i < other.size(); i++) {
            this->_data[i] = other[i];
        }
        // Return the newly copied array
        return *this;
    }

    // Move assignment operator
    // No-Throw Guarantee
    TMSArray & operator=(TMSArray && other) noexcept {
        // Move the data to our new array
        this->_size = other._size;
        this->_capacity = other._capacity;
        this->_data = other._data;
        // Clear the data of the old array
        other._size = 0;
        other._capacity = 0;
        other._data = nullptr;
        // Return the newly moved array
        return *this;
    }

    // Dctor
    // No-Throw Guarantee
    ~TMSArray()
    {
        delete [] _data;
    }

// ***** TMSArray: general public operators *****
public:

    // operator[] - non-const & const
    // Pre:
    //     index provided < this->size()
    // No-Throw Guarantee
    value_type & operator[](size_type index)
    {
        return _data[index];
    }
    const value_type & operator[](size_type index) const
    {
        return _data[index];
    }

// ***** TMSArray: general public functions *****
public:

    // size
    // No-Throw Guarantee
    size_type size() const noexcept
    {
        return _size;
    }

    // empty
    // No-Throw Guarantee
    bool empty() const noexcept
    {
        return size() == 0;
    }

    // begin - non-const & const
    // No-Throw Guarantee
    iterator begin() noexcept
    {
        return _data;
    }
    const_iterator begin() const noexcept
    {
        return _data;
    }

    // end - non-const & const
    // No-Throw Guarantee
    iterator end() noexcept
    {
        return begin() + size();
    }
    const_iterator end() const noexcept
    {
        return begin() + size();
    }

    // resize
    // Pre:
    //     newsize <= DEFAULT_CAP
    // Strong Guarantee
    void resize(size_type newsize) {
        // Ensure preconditions are met
        assert(newsize <= DEFAULT_CAP);
        // Only create a new array if we need more space than is allocated
        // In all cases, we still move the size value to the selected value
        if (newsize > this->size()) {
            // Initialize new capacity
            value_type* new_data = new value_type[newsize];
            // Copy relevant objects over
            for (size_type i = 0; i < this->size(); i++) {
                new_data[i] = this->_data[i];
            }
            // Delete the old array (including its elements)
            delete this->_data;
            // Move the new pointer to the new array
            this->_data = new_data;
            // Reassign our capacity to the update one
            this->_capacity = newsize;
        }
        // Reassign size
        this->_size = newsize;
    }

    // insert
    // Pre:
    //     this->begin() < pos <= this->end()
    // Strong Guarantee
    iterator insert(iterator pos,
                    // Using pass by reference
                    value_type item) {
        // Cover overflow case
        if (this->size() == this->_capacity) { this->resize(this->size() + 1); }
        // Initialize iterator at the end of the filled portion of the array
        iterator index = (iterator) this->size() - 1;
        // Move every item to the left of the insertion point one position to the right
        for (index; index > pos - 1; index--) {
            this->_data[(size_type) index] = std::move(this->_data[(size_type) index - 1]);
        }
        // Insert item
        this->_data[(size_type) index] = item;
        // Return the iterator position of the inserted element
        return index;
    }
        // Above, passing by value is appropriate, since our value type
        // is int. However, if the value type is changed, then a
        // different parameter-passing method may need to be used.

    // erase
    // Pre:
    //     this->begin() <= pos <= this->end()
    // Strong Guarantee
    iterator erase(iterator pos) {
        // Initialize iterator right before the position we're removing
        iterator index = pos;
        // Move every item to the left of the deletion point one position to the right
        for (index; (size_type) index < this->size(); index++) {
            this->_data[(size_type) index] = std::move(this->_data[(size_type) index + 1]);
        }
        // Decrease size
        this->_size--;
        // Return the iterator position of the inserted element
        return pos;
    }

    // push_back
    // Strong Guarantee
    void push_back(value_type item)
        // Above, passing by value is appropriate, since our value type
        // is int. However, if the value type is changed, then a
        // different parameter-passing method may need to be used.
    {
        insert(end(), item);
    }

    // pop_back
    // Strong Guarantee
    void pop_back() {
        erase(end()-1);
    }

    // swap
    // No-Throw Guarantee
    void swap(TMSArray & other) noexcept {
        // Store temp values for swap
        size_type temp_size = this->size();
        size_type temp_capacity = this->_capacity;
        value_type * temp_data = this->_data;
        // Overwrite currently stored values with other's values
        this->_size = other.size();
        this->_capacity = other._capacity;
        this->_data = other._data;
        // Copy temp values into other's values
        other._size = temp_size;
        other._capacity = temp_capacity;
        other._data = temp_data;
    }

// ***** TMSArray: data members *****
private:

    // Below, _capacity must be declared before _data
    size_type    _capacity;  // Size of our allocated array
    size_type    _size;      // Size of client's data
    value_type * _data;      // Pointer to our array

};  // End class TMSArray


#endif  //#ifndef FILE_TMSArray_HPP_INCLUDED
