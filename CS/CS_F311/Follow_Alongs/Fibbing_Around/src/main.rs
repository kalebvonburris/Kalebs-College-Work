#[macro_use]
extern crate timeit;


fn fib(n: u64) -> u64 {
    match n {
        0 | 1 => n,
        _ => fib(n-1) + fib(n-2)
    }
}

fn fib_iterate(n: u64) -> u64 {
    let mut previous = 1;
    let mut current = 0;

    for _ in 0..n {
        let next = previous + current;
        previous = current;
        current = next;
    }

    current
}

fn fib_recursive(n: u64) -> (u64, u64) {
    if n == 0 { return (1, 0); }
    
    let (prev, curr) = fib_recursive(n - 1);

    (curr, prev+curr)
}

fn fib_better(n: u64) -> u64 {
    let (_, curr) = fib_recursive(n);

    curr
}

fn main() {
    println!("{}", fib_better(93));
}
