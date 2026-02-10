//! # Parser

use crate::lexer::{Lexeme, NumericLiteral};

pub struct Parser {
    lexemes: Vec<(Lexeme, String)>,
    lexstr: String,
    lexcat: Lexeme,
}

impl Parser {
    pub fn new(mut lexemes: Vec<(Lexeme, String)>) -> Self {
        // In order to use Vec::pop, we reverse the vector so that the
        // first lexeme is at the end of the vector.
        lexemes.reverse();
        Parser {
            lexemes,
            lexstr: "".to_string(),
            lexcat: Lexeme::None,
        }
    }

    pub fn parse(&self) -> Result<(), String> {
        // Placeholder for parsing logic
        Ok(())
    }

    fn advance(&mut self) {
        let (lexcat, lexstr) = self.lexemes.pop().unwrap_or((Lexeme::None, "".to_string()));

        if lexcat != Lexeme::None {
            self.lexcat = lexcat;
            self.lexstr = lexstr;
        }
    }

    fn match_str(&self, expected: &str) -> bool {
        self.lexstr == expected
    }

    fn match_lexeme(&self, expected: &Lexeme) -> bool {
        self.lexcat == *expected
    }
}
