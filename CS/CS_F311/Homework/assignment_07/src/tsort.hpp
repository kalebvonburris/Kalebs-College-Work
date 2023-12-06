// tsort.hpp COMPLETE
// Kaleb Burris
// 2023-12-4
//
// For CS 311 Fall 2023
// Header for function template treesort
// There is no associated source file.

#pragma once

#include <iterator>
// For std::iterator_traits
#include <vector>
// For std::vector
#include<memory>
// For std::unique_ptr

// Define a node in the binary search tree.
template<typename Value>
struct BSTreeNode {
    Value data;
    std::unique_ptr<BSTreeNode> left;
    std::unique_ptr<BSTreeNode> right;

    // Constructor initializes the node with a value.
    BSTreeNode(const Value& val) : 
        data(val), 
        left(nullptr), 
        right(nullptr) 
    {}
};

// Insert a value into the binary search tree.
template<typename Value>
void insert(std::unique_ptr<BSTreeNode<Value>>& root, const Value& value) {
    // If the value is at end of a branch, insert it
    if (!root) {
        root = std::make_unique<BSTreeNode<Value>>(value);
    } 
    // Otherwise, insert the value to the left branch if its value is less than the node
    else if (value < root->data) {
        insert(root->left, value);
    } 
    // And to the right if it's greater than the node
    else {
        insert(root->right, value);
    }
}

// Perform an in-order traversal of the binary search tree,
// calling the given function on each node.
template<typename Value, typename Fn>
void traverse(const std::unique_ptr<BSTreeNode<Value>>& node, Fn fn) {
    // Given that the given node isn't nullptr
    if (node) {
        // Apply the function to the left node first (all smaller values)
        traverse(node->left, fn);
        // Apply the function to the node
        fn(node->data);
        // Apply the function to the right node last (all larger value)
        traverse(node->right, fn);
        // By doing left (smaller values), middle (current value), right (larger values)
        // we do an in-order traversal which allows a sort on the items
    }
}

// Sort a given range using Treesort.
// Pre: 
//    FDIter is a forward iterator type.
// Exception safety guarantee: 
//    Strong Guarantee.
template<typename FDIter>
void treesort(FDIter first, FDIter last) {
    // Stolen from the homework page: https://www.cs.uaf.edu/~chappell/class/2023_fall/cs311/docs/d-assn07d.html
    // This ensures the given value is in fact an iterator.
    using Value = typename std::iterator_traits<FDIter>::value_type;

    // Create an empty binary search tree.
    std::unique_ptr<BSTreeNode<Value>> root;

    // Insert all elements from the range into the binary search tree.
    for (FDIter iter = first; iter != last; ++iter) {
        insert(root, *iter);
    }

    // Start the iterator for our sort at the beginning of the input.
    FDIter iter = first;

    // Perform an in-order traversal to extract the sorted elements.
    // Uses C++'s awful lambda notation; I thought this was a dereference at first but it's just a parameter.
    auto insert_sort = [&iter](const Value& value) {
        // Store the given value at the iterator location.
        *iter = value;
        // Move to the next element
        ++iter;
    };
    
    // Use an in-order traversal to apply 
    traverse(root, insert_sort);
}