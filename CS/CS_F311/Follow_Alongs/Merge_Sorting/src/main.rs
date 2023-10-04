#![feature(test)]

fn merge_sort(arr: & mut [i64]) {
    arr.sort();
}

fn main() {
    let mut arr: Vec<i64> = vec![9, 8, 7, 6, 5, 4, 3, 2, 1, 0];
    merge_sort(&mut arr);
    println!("{arr:?}");
}

extern crate test;

#[cfg(test)]
mod tests {
    use rand::Rng;
    use test::Bencher;

    use crate::merge_sort;

    #[bench]
    fn bench_merge_sort(b: &mut Bencher) {
        // Generate random vecs
        let mut rng = rand::thread_rng();
        
        let num_vecs = 100;

        let mut vecs: Vec<Vec<i64>> = Vec::with_capacity(num_vecs);

        for _ in 0..num_vecs {
            vecs.push((0..100).map(|_| rng.gen_range(0..20)).collect());
        }

        b.iter(move || {
            // Inner closure, the actual test
            for mut vec in vecs.to_owned() {
                merge_sort(&mut vec);
            }
        });
    }

    #[bench]
    fn bench_std_sort(b: &mut Bencher) {
        // Generate random vecs
        let mut rng = rand::thread_rng();
        
        let num_vecs = 100;

        let mut vecs: Vec<Vec<i64>> = Vec::with_capacity(num_vecs);

        for _ in 0..num_vecs {
            vecs.push((0..100).map(|_| rng.gen_range(0..20)).collect());
        }

        b.iter(move || {
            // Inner closure, the actual test
            for mut vec in vecs.to_owned() {
                vec.sort();
            }
        });
    }
}
