// hsscount.cpp
// Kaleb Burris
// 10-7-2023
// Implementation of the hssCount function.

#include "hsscount.hpp"
#include <vector>
// For vector
#include <iostream>

// Wrapper function for hssCount_recurse.
// Pre:
//     All dimensions provided are >= 1
//     All other values are >= 0
int hssCount(
    int dim_x,      int dim_y,
    int hole_x,     int hole_y,
    int start_x,    int start_y,
    int finish_x,   int finish_y) {

    hssData data = {
        dim_x,    dim_y,
        hole_x,   hole_y,
        start_x,  start_y,
        finish_x, finish_y
    };

    // Initialize a vector of size dim_x * dim_y with all falses
    std::vector<bool> paths_taken(dim_x * dim_y, false);

    return hssCount_recurse(data, paths_taken);
}

// Implementation of hssCount_recurse.
// Pre:
//     hssData: All values must be >= 0. dim_x and dim_y must be > 0.
//     paths_taken: Must be instantiated at size: dim_x * dim_y.
int hssCount_recurse(hssData data, std::vector<bool> paths_taken) {
    // Check if we moved out of bounds.
    if (data.current_x > data.dim_x || data.current_x < 0) return 0;
    if (data.current_y > data.dim_y || data.current_y < 0) return 0;
    // Check if we moved into the hole.
    if (data.current_x == data.hole_x && data.current_y == data.hole_y) return 0;
    // Check if we moved to the end.
    if (data.current_x == data.finish_x && data.current_y == data.finish_y) return 1;
    // value for storing the number of iterations we calculate.
    int hss_count = 0;
    // Store the starting x and y values for this recursive iteration.
    int starting_x = data.current_x;
    int starting_y = data.current_y;
    // Loop over all 8 possible moves.
    for (int y = 1; y >= -1; y--) {
        for (int x = 1; x >= -1; x--) {
            // Skip moving to the current position.
            if (x == 0 && y == 0) continue;
            // Create a copy of the paths we've taken.
            std::vector<bool> temp_paths_taken(paths_taken);
            // Tell the next iteration that we were here.
            temp_paths_taken[data.current_x * data.current_y] = true;
            // Update our position.
            data.current_x = starting_x + x;
            data.current_y += starting_y + y;
            // Grab the number of recusive solutions.
            hss_count += hssCount_recurse(data, temp_paths_taken);
        }
    }

    return hss_count;
}

bool tile_explored(int dir_x, int dir_y, std::vector<bool> paths_taken) {
    return paths_taken[dir_x * dir_y];
}