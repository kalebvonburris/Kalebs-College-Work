// player.hpp
// Kaleb Burris
// 09-06-2023
//
// The header file containing the Player class for Assignment 1.

#include <string>;

#pragma once

class Player {
public:

    // Default constructor
    Player() : 
    real_name("UNKNOWN"),
    user_name("UNKNOWN"),
    games_played(0)
    {}

    // Constuctor given arguments
    Player(std::string user_name, std::string real_name, unsigned int games_played) :
    user_name(user_name), real_name(real_name), games_played(games_played)
    {}

    // Have the compiler generate the following functions:
    //    Copy constructor
    Player(const Player &other) = default;
    //    Copy assignment
    Player &operator=(const Player &other) = default;
    //    Move constructor
    Player(Player &&other) = default;
    //    Move assignment
    Player &operator=(Player &&other) = default;
    // Destructor
    ~Player() = default;

    // Getters
    std::string get_name()          const { return user_name; }
    std::string get_real_name()     const { return real_name; }
    unsigned int get_games_played() const { return games_played; }

    // Setters
    void set_name(std::string user_name)                { this->user_name = user_name; }
    void set_real_name(std::string real_name)           { this->real_name = real_name; }
    void set_games_played(unsigned int games_played)    { this->games_played = games_played; }

    // Member functions

    bool inactive() { return games_played == 0; }
    // I believe the C++ naming convention 
    // is to snake_case function names, this
    // is giving me Java flashbacks.
    std::string toString() {
        return this->real_name + " (" + this->user_name + ") : " + std::to_string(this->games_played);
    }

private:

    std::string user_name;
    std::string real_name;
    unsigned int games_played;

}; // End of Player class