// hsscount.hpp
// Kaleb Burris
// 10-7-2023

#pragma once

#include <vector>
// For vector

// Wrapper function for hssCount_recurse.
// Pre:
//     All dimensions provided are >= 1
//     All other values are >= 0
int hssCount(int dim_x, int dim_y,
             int hole_x, int hole_y,
             int start_x, int start_y,
             int finish_x, int finish_y);

// A struct for handling hssCount data.
// I used a struct because I hate classes
// and this was way nicer to use.
struct hssData {
    int dim_x; int dim_y;
    int hole_x; int hole_y;
    int current_x; int current_y;
    int finish_x; int finish_y;
};

// Implementation of hssCount_recurse.
// Pre:
//     hssData: All values must be >= 0. dim_x and dim_y must be > 0.
//     paths_taken: Must be instantiated at size: dim_x * dim_y.
int hssCount_recurse(hssData data, std::vector<bool> paths_taken);