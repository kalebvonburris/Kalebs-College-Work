// da6_test.cpp
// Kaleb Burris
// 2023-11-20
// Assignment 6 header file.

#pragma once

#include "llnode2.hpp"
// For LLNode2, size()
#include <stdexcept>
// For std::out_of_range
#include <utility>
// For std::pair

// reverseList() - Reverses a linked lists' nodes
template<typename ValType>
void reverseList(std::unique_ptr<LLNode2<ValType>> & head) {
    // Sets the head to point to a nullptr
    std::unique_ptr<LLNode2<ValType>> new_head = nullptr;
    while (head != nullptr) {
        std::swap(new_head, head);
        std::swap(head, new_head.get()->_next);
    }
    std::swap(head, new_head);
}

// SlowMap Class
// Stores data in key-value pairs in a slow manner.
template<typename KeyType, typename DataType>
class SlowMap {
public:
    // Ctrors
    // Default ctor
    SlowMap() : head(nullptr) {}

    // 1 parameter ctor
    SlowMap(std::unique_ptr<LLNode2<std::pair<KeyType, DataType>>> head) : head(head) 
    {}

    // set() - Creates a new LLNode and sets its key/value to the given values.
    void set(KeyType key, DataType value) {
        // Try to modify currently existing value
        try {
            auto dup = this->get(key);
        } 
        // Otherwise, insert new value
        catch (...) {
            // Create new pair
            std::pair new_pair = std::pair<KeyType, DataType>(key, value);
            // Push new pair to the front of the list
            head = std::make_unique<LLNode2<std::pair<KeyType, DataType>>>(new_pair, head);
        }
    }

    // get() - Returns a reference to the given key's value.
    const DataType & get(KeyType key) const {
        auto p = head.get();      // Iterates through list
        while (p != nullptr)
        {
            KeyType curr_key = p->_data.first;
            if (curr_key == key) {
                return p->_data.second;
            }
            p = p->_next.get();
        }
        throw std::out_of_range("SlowMap does not contain provided key.");
    }
    DataType & get(KeyType key) {
        auto p = head.get();      // Iterates through list
        while (p != nullptr)
        {
            KeyType curr_key = p->_data.first;
            if (curr_key == key) {
                return p->_data.second;
            }
            p = p->_next.get();
        }
        throw std::out_of_range("SlowMap does not contain provided key.");
    }

    void erase(KeyType key) {
        auto curr = head.get();      // Iterates through list
        LLNode2<std::pair<KeyType, DataType>> * prev = nullptr;
        while (curr != nullptr)
        {
            auto next = curr->_next.get();
            KeyType curr_key = curr->_data.first;
            if (curr_key == key) {
                // Delete head case
                if (prev) {
                    prev->_next = std::move(curr->_next);
                }
                delete curr;
                return;
            }
            prev = curr;
            curr = curr->_next.get();
        }
    }

    template<typename Function>
    void traverse(Function f) {
        auto node = head.get();
        while (node != nullptr) {
            f(node->_data.first, node->_data.second);
            node = node->_next.get();
        }
    }

    // present() - Returns true if the key is present in the map, false otherwise.
    bool present(KeyType key) {
        try {
            get(key);
            return true;
        } catch (...) {
            return false;
        }
    }

    // size() - Returns the size of the map.
    std::size_t size() const {
        auto p = head.get();      // Iterates through list
        std::size_t counter = 0;  // Number of nodes so far
        while (p != nullptr)
        {
            p = p->_next.get();
            ++counter;
        }
        return counter;
    }

    // empty() - Returns true if the map is empty.
    bool empty() const {
        return this->size() == 0;
    }

    // Dtor
    ~SlowMap() {
        delete head.get();
    }

    // No copy/move operations.
    SlowMap(const SlowMap & other) = delete;
    SlowMap & operator=(const SlowMap & other) = delete;
    SlowMap(SlowMap && other) = delete;
    SlowMap & operator=(SlowMap && other) = delete;

private:
    std::unique_ptr<LLNode2<std::pair<KeyType, DataType>>> head;
}; // End of SlowMap class