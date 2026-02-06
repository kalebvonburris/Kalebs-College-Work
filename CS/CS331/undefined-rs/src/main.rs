use undefined_rs::lexer::Lexer;

fn main() {
    let msg = "1 2 3 4 ; 5 asvcs err(2.234444) 2.2.2.2  2e10 1.234E123".to_string();

    let lexemes = Lexer::new(msg).lex_input();

    for (l, s) in lexemes {
        println!("{:?} : {:?}", l, s);
    }
}
