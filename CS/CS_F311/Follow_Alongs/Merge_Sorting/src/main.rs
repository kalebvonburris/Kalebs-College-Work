fn merge_sort(arr: & mut Vec<i32>) {
    arr.sort();
}

fn main() {
    let mut arr: Vec<i32> = vec![9, 8, 7, 6, 5, 4, 3, 2, 1, 0];
    merge_sort(&mut arr);
    println!("{arr:?}");
}