//! # Lexer

pub struct Lexer {
    Code: String,
    CurrentLexem: String,
    Index: usize,
    State: State,
}

#[derive(Debug, PartialEq)]
pub enum State {
    Start,
    Letter,
    End,
}

impl Lexer {
    pub fn new(s: String) -> Self {
        Self {
            Code: s,
            CurrentLexem: String::new(),
            Index: 0,
            State: State,
        }
    }

    pub fn lex_input(&mut self, input: String) -> Vec<(Lexem, String)> {
        let lexemes = Vec::new();

        while self.Index < self.Code.len() {
            // Handle None state - start
            if self.State == State::Start {
                if self.ch().is_alphabetic() || self.ch() == '_' {
                    self.State = State::Start;
                }
            }
        }

        lexemes
    }

    pub fn add_one(&mut self) {
        let c = self.ch();

        self.CurrentLexem.push(c);
        self.Index += 1;
    }

    pub fn ch(&mut self) -> char {
        self.Code.chars().nth(self.Index).unwrap()
    }
}

#[derive(Debug, PartialEq)]
pub enum Lexem {
    None,
    Keyword,
    Identifier,
    NumericLiteral,
    Operator,
    Punctuation,
    Malformed(LexingError),
}

#[derive(Debug, PartialEq)]
pub enum LexingError {
    NonLegalChar(char),
    KeywordUsed(String),
    NoLexemFound,
}

pub const LEGAL_CHARACTERS: core::ops::RangeInclusive<char> = ' '..='~';

pub const KEYWORDS: &[&str] = &["begin", "end", "print"];

pub const OPERATORS: &[&str] = &[
    "+", "-", "*", "/", "++", "--", ".", "=", "==", "+=", "-=", "*=", "/=",
];

impl Lexem {}
