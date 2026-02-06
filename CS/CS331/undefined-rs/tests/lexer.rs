#[cfg(test)]
mod tests {
    use undefined_rs::lexer::*;

    /// Helper function so I don't have to type `String::new`
    /// a billion times.
    fn parse_test_output(input: Vec<(Lexeme, &str)>) -> Vec<(Lexeme, String)> {
        input
            .iter()
            .map(|(l, s)| {
                let string = s.to_string();
                (l.clone(), string)
            })
            .collect()
    }

    #[test]
    fn hello_world() {
        let test = "Hello World".to_string();

        let lexemes = Lexer::new(test).lex_input();

        assert_eq!(
            lexemes,
            parse_test_output(vec![
                (Lexeme::Identifier, "Hello"),
                (Lexeme::Identifier, "World"),
            ])
        );
    }
}
