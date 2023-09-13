// player.hpp
// Kaleb Burris
// 09-12-2023
//
// The header file containing the Player class for Assignment 1.

// For string
#include <string>
// For assert()
#include <cassert>
// For std::ostream
#include <ostream>

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
    Player(std::string u, std::string r, unsigned int g) :
    user_name(u), real_name(r), games_played(g)
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
    //    Destructor
    ~Player() = default;

    // Getters //
    // I believe the C++ naming convention 
    // is to snake_case function names, this
    // is giving me Java flashbacks.
    std::string getUsername()          const { return user_name; }
    std::string getRealName()     const { return real_name; }
    unsigned int getGames() const { return games_played; }

    // Setters //
    void setUsername(std::string u)     { this->user_name = u; }
    void setRealName(std::string r)     { this->real_name = r; }
    void setGames(unsigned int g)       { this->games_played = g; }

    // Member functions //
    
    //    Returns the active state of the player (games_played > 0)
    bool inactive() const { return games_played == 0; }
    
    //    Returns a stringified representation of the player in the form
    //      real_name (user_name) : games_played
    std::string toString() const {
        return this->real_name + " (" + this->user_name + "): " + std::to_string(this->games_played);
        //         Selena Gomez    (      Mabel Mora       ):                   15
    }

    // Operator Functions //
    //    Post-increment operator (++player)
    Player & operator++() {
        this->games_played += 1;
        return *this;
    }

    //    Pre-increment operator (player++)
    Player operator++(int) {
        assert(this->games_played > 0);
        Player temp(*this);
        ++(*this);
        return temp;
    }

    //    Post-decrement operator (--player)
    Player & operator--() {
        // Ignore --0 case
        if (this->games_played == 0) return *this;
        this->games_played -= 1;
        return *this;
    }

    //    Pre-decrement operator (player--)
    Player operator--(int) {
        Player temp(*this);
        --(*this);
        return temp;
    }

private:

    std::string user_name;
    std::string real_name;
    unsigned int games_played;

}; // End of Player class

// Non-member Functions //

// osteam operator << (steam << player)
std::ostream & operator<<(std::ostream &stream, const Player & player) {
    stream << player.toString(); 
    return stream;
}

// Equality operator == (player1 == player2)
bool operator==(const Player & a, const Player & b) {
    return 
        (a.getGames()    == b.getGames())    && 
        (a.getRealName() == b.getRealName()) && 
        (a.getUsername() == b.getUsername());
}

// Inequality operator != (player1 != player2)
bool operator!=(const Player & a, const Player & b) {
    return !(a == b);
}

