// squarer_test.cpp
// Kaleb Burris
// 2023-12-10
//
// For CS 311 Fall 2023
// Test program for class Squarer
// For Assignment 8, Exercise B
// Uses the "doctest" unit-testing framework, version 2
// Requires doctest.h, squarer.hpp

// Includes for code to be tested
#include "squarer.hpp"       // For class Squarer

// Includes for the "doctest" unit-testing framework
#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
                             // doctest writes main for us
#include "doctest.h"         // For doctest framework


// *********************************************************************
// Test Cases
// *********************************************************************

TEST_CASE("Const/Non-Const") {
    SUBCASE("Const Test") {
        const Squarer sq;
        INFO("Ensure const squarer works");
        REQUIRE(sq(1) == 1);
    }
    SUBCASE("Non-Const Test") {
        Squarer sq;
        INFO("Ensure const squarer works");
        REQUIRE(sq(1) == 1);
    }
}



TEST_CASE("Numerics")
{
    SUBCASE("Squarer: Poitive ints") {
        Squarer sq;
        INFO("1 squared is 1");
        REQUIRE(sq(1) == 1);
        INFO("5 squared is 25");
        REQUIRE(sq(5) == 25);
        INFO("10 squared is 100");
        REQUIRE(sq(10) == 100);
        INFO("12 squared is 144");
        REQUIRE(sq(12) == 144);
        INFO("32768 squared is 1073741824");
        REQUIRE(sq(32768) == 1073741824);
    }

    SUBCASE("Squarer: Negative ints") {
        Squarer sq;
        INFO("-1 squared is 1");
        REQUIRE(sq(-1) == 1);
        INFO("-5 squared is 25");
        REQUIRE(sq(-5) == 25);
        INFO("-10 squared is 100");
        REQUIRE(sq(-10) == 100);
        INFO("-12 squared is 144");
        REQUIRE(sq(-12) == 144);
        INFO("-32768 squared is 1073741824");
        REQUIRE(sq(-32768) == 1073741824);
    }

    SUBCASE("Squarer: Poitive floats") {
        Squarer sq;
        INFO("1.0 squared is 1.0");
        REQUIRE(sq(1.0) == doctest::Approx(1.0));
        INFO("2.5 squared is 6.25");
        REQUIRE(sq(2.5) == doctest::Approx(6.25));
        INFO("3.14 squared is 9.8596");
        REQUIRE(sq(3.14) == doctest::Approx(9.8596));
        INFO("100000.0 squared is 10000000000.0");
        REQUIRE(sq(100000.0) == doctest::Approx(10000000000));
    }

    SUBCASE("Squarer: Negative floats") {
        Squarer sq;
        INFO("-1.0 squared is 1.0");
        REQUIRE(sq(-1.0) == doctest::Approx(1.0));
        INFO("-2.5 squared is 6.25");
        REQUIRE(sq(-2.5) == doctest::Approx(6.25));
        INFO("-3.14 squared is 9.8596");
        REQUIRE(sq(-3.14) == doctest::Approx(9.8596));
        INFO("-100000.0 squared is 10000000000.0");
        REQUIRE(sq(-100000.0) == doctest::Approx(10000000000));
    }

    SUBCASE("Squarer: Int Range")
    {
        INFO("Square int range 1..1000");
        Squarer sq;
        for (int i = 1; i < 1000; ++i) {
            REQUIRE(sq(i) == i * i);
        }
    }

    SUBCASE("Squarer: float Range")
    {
        INFO("Square float range 0.5..500.0");
        Squarer sq;
        for (float i = 0.5; i < 500.0; ++i) {
            REQUIRE(sq(i) == doctest::Approx(i * i));
        }
    }

    SUBCASE("Squarer: double Range")
    {
        INFO("Square double range 0.5..500.0");
        Squarer sq;
        for (double i = 0.5; i < 500.0; ++i) {
            REQUIRE(sq(i) == doctest::Approx(i * i));
        }
    }
}