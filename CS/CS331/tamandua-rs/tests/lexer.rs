#[cfg(test)]
mod tests {
    use tamandua_rs::lexer::*;

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
    fn test_identifiers() {
        let lexer = Lexer::new("a".to);

        assert_eq!(parse_test_output(vec![]),)
    }
}
