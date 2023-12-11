// wordcount.cpp
// Kaleb Burris
// 2023-12-09
//
// Assignment 8 - Excercise A
// Takes a user's input file, counts the instances of
// each word and prints each word and their number of occurrences.

#include <iostream>
using std::cin;
using std::cout;
using std::cerr;

#include <fstream>
using std::ifstream;

#include <string>
using std::string;

#include <sstream>
using std::stringstream;

#include <map>
using std::map;

int main(void) {
    // Declare and aquire the file name from the user
    string file_name;
    cin >> file_name;
    // Create a file stream
    ifstream file(file_name, ifstream::in);
    // Check for a valid file steam
    if (!file.is_open()) {
        cerr << "Could not open file: " << file_name << "\n";
        return 1;
    }
    // Create a map to store words found
    map<string, int> d_words; 

    while(file.good()) {
        // Error and end of file checking
        if (!file) {
            if (file.eof()) {
                break;
            }
            cerr << "Encountered an error while reading file: " << file_name << "\n";
            return 1;
        }
        // Grab a line and store it in memory
        string line;
        std::getline(file, line);

        // Extract each word and insert it or iterate it in the map
        stringstream stream(line);
        string word;
        while(std::getline(stream, word, ' ')) {
            d_words[word] += 1;
        }
    }

    // Header for print out
    cout << "Number of distinct words: " << d_words.size() << "\n\n";

    // Grab iterators to the beginning and ending of the map
    auto start = d_words.begin();
    auto end = d_words.end();
    // Print out the map
    for (start; start != end; start++) {
        cout << start->first << ": " << start->second << "\n";
    }
}