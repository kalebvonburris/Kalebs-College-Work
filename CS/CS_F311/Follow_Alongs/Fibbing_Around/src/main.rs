#[macro_use]
extern crate timeit;
use bigdecimal::BigDecimal;

fn fib_fast(n: u64) -> String {
    let big_d: BigDecimal = BigDecimal::from(&n);
    big_d.sqrt().unwrap().to_string()
}

fn main() {
    let val: u64 = 5;
    println!("sqrt({}) = {}", val, fib_fast(val));
    timeit!({fib_fast(val);});
}
