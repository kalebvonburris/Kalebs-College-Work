#![feature(test)]

extern crate test;

use test::Bencher;

use rayon::prelude::*;

fn sum_of_squares(input: &[i32]) -> i32 {
    input.iter().map(|i| i * i).sum()
}

fn main() {
    ()
}

#[bench]
fn test(b: &mut Bencher) {
    let vals = &[16; 1000000];

    b.iter(|| sum_of_squares(vals))
}
