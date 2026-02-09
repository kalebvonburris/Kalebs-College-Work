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

    #[test]
    fn numerics() {
        let test = "90 1.22455555555555555555555555555555555 .2999 10.0e10000".to_string();

        let lexemes = Lexer::new(test).lex_input();

        assert_eq!(
            lexemes,
            parse_test_output(vec![
                (Lexeme::NumericLiteral(NumericLiteral::Integer), "90"),
                (
                    Lexeme::NumericLiteral(NumericLiteral::Float),
                    "1.22455555555555555555555555555555555"
                ),
                (Lexeme::NumericLiteral(NumericLiteral::Float), ".2999"),
                (
                    Lexeme::NumericLiteral(NumericLiteral::Scientific),
                    "10.0e10000"
                ),
            ])
        );
    }

    #[test]
    fn keywords() {
        let keywords = KEYWORDS;

        let test_string = keywords.join(" ");

        let lexemes = Lexer::new(test_string).lex_input();

        let expected: Vec<(Lexeme, String)> = keywords
            .iter()
            .map(|k| (Lexeme::Keyword, k.to_string()))
            .collect();

        assert_eq!(lexemes, expected);
    }

    #[test]
    fn identifiers() {
        let identifiers = vec![
            "variable",
            "myVar",
            "var123",
            "private_Var",
            "camelCase",
            "snake_case",
        ];

        let test_string = identifiers.join(" ");

        let lexemes = Lexer::new(test_string).lex_input();

        let expected: Vec<(Lexeme, String)> = identifiers
            .iter()
            .map(|id| (Lexeme::Identifier, id.to_string()))
            .collect();

        assert_eq!(lexemes, expected);
    }

    #[test]
    fn operators() {
        let operators = OPERATORS;

        let test_string = operators.join(" ");

        let lexemes = Lexer::new(test_string).lex_input();

        let expected: Vec<(Lexeme, String)> = operators
            .iter()
            .map(|op| (Lexeme::Operator, op.to_string()))
            .collect();

        assert_eq!(lexemes, expected);
    }

    #[test]
    fn punctuation() {
        let test = "}{{((()))}{{{})))((}}}}}}".to_string();

        let lexemes = Lexer::new(test.clone()).lex_input();

        let expected: Vec<(Lexeme, String)> = test
            .chars()
            .map(|c| (Lexeme::Punctuation, c.to_string()))
            .collect();

        assert_eq!(lexemes, expected);
    }
}
