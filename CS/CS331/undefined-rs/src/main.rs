use undefined_rs::lexer::Lexer;

fn main() {}

#[cfg(test)]
mod tests {
    use undefined_rs::lexer::Lexeme;

    use super::*;

    #[test]
    fn hello_world() {
        let test = "Hello World".to_string();

        let lexemes = Lexer::new(test).lex_input();

        assert_eq!(
            lexemes,
            vec![
                (Lexeme::Identifier, String::from("Hello")),
                (Lexeme::Identifier, String::from("World")),
            ]
        );
    }
}
