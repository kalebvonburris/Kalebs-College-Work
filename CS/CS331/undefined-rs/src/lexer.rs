//! # Lexer

pub struct Lexer {
    code: String,
    current_lexem: String,
    current_category: Lexeme,
    index: usize,
    state: State,
    found_lexems: Vec<(Lexeme, String)>,
}

#[derive(Debug, PartialEq)]
pub enum State {
    Start,
    Letter,
    Num,
    End,
}

#[derive(Debug, PartialEq, Clone)]
pub enum Lexeme {
    None,
    Keyword,
    Identifier,
    NumericLiteral(NumericLiteral),
    Operator,
    Punctuation,
    Malformed(LexingError),
}

#[derive(Debug, PartialEq, Clone)]
pub enum NumericLiteral {
    Integer,
    Float,
    MalformedFloat,
    Scientific,
}

#[derive(Debug, PartialEq, Clone)]
pub enum LexingError {
    NonLegalChar(char),
    KeywordUsed(String),
    NoLexemeFound,
    ImproperNumericLiteral,
}

pub const LEGAL_CHARACTERS: core::ops::RangeInclusive<char> = ' '..='~';

pub const KEYWORDS: &[&str] = &["begin", "end", "print"];

pub const OPERATORS: &[&str] = &[
    "+", "-", "*", "/", "++", "--", ".", "=", "==", "+=", "-=", "*=", "/=",
];

impl Lexer {
    pub fn new(s: String) -> Self {
        Self {
            code: s,
            current_lexem: String::new(),
            current_category: Lexeme::None,
            index: 0,
            state: State::Start,
            found_lexems: Vec::new(),
        }
    }

    pub fn lex_input(&mut self) -> Vec<(Lexeme, String)> {
        while self.index <= self.code.len() {
            // Handle None state - start
            match self.state {
                State::Start => self.handle_start(),
                State::Letter => self.handle_letter(),
                State::Num => self.handle_num(),
                State::End => self.handle_end(),
            }
        }

        self.found_lexems.clone()
    }

    pub fn handle_start(&mut self) {
        match self.curr_char() {
            'a'..='z' | 'A'..='Z' | '_' => {
                self.add_one();
                self.state = State::Letter;
            }
            ' ' => self.drop_one(),
            '0'..='9' => {
                self.add_one();
                self.state = State::Num;
                self.current_category = Lexeme::NumericLiteral(NumericLiteral::Integer)
            }
            _ => {
                self.add_one();
                self.state = State::End;
                self.current_category = Lexeme::Punctuation;
            }
        };
    }

    pub fn handle_letter(&mut self) {
        if self.curr_char().is_ascii_alphanumeric() || self.curr_char() == '_' {
            self.add_one();
        } else {
            self.state = State::End;
            if KEYWORDS.contains(&self.current_lexem.as_str()) {
                self.current_category = Lexeme::Keyword;
            } else {
                self.current_category = Lexeme::Identifier;
            }
        }
    }

    pub fn handle_num(&mut self) {
        if let Lexeme::NumericLiteral(c) = self.current_category.clone() {
            match self.curr_char() {
                '0'..='9' => self.add_one(),
                '.' => match c {
                    NumericLiteral::Integer => {
                        self.current_category = Lexeme::NumericLiteral(NumericLiteral::Float);
                        self.add_one();
                    }
                    NumericLiteral::Float
                    | NumericLiteral::MalformedFloat
                    | NumericLiteral::Scientific => {
                        self.current_category =
                            Lexeme::NumericLiteral(NumericLiteral::MalformedFloat);
                        self.add_one();
                    }
                },
                'e' | 'E' => {
                    self.current_category = Lexeme::NumericLiteral(NumericLiteral::Scientific);
                    self.add_one();
                    self.handle_scientific();
                }
                _ => self.state = State::End,
            }
        } else {
            self.current_category = Lexeme::Malformed(LexingError::ImproperNumericLiteral);
            self.state = State::End;
        }
    }

    pub fn handle_scientific(&mut self) {
        // Fist thing after the 'e'/'E' isn't  a number
        if !self.curr_char().is_ascii_digit() && self.curr_char() != '-' {
            self.current_category = Lexeme::Malformed(LexingError::ImproperNumericLiteral);
            self.state = State::End;
        }

        if self.curr_char() == '-' {
            self.add_one();
        }

        while self.curr_char().is_ascii_digit() {
            self.add_one();
        }

        self.state = State::End;
    }

    pub fn handle_end(&mut self) {
        if self.current_category == Lexeme::NumericLiteral(NumericLiteral::MalformedFloat) {
            self.current_category = Lexeme::Malformed(LexingError::ImproperNumericLiteral);
        }

        self.found_lexems
            .push((self.current_category.clone(), self.current_lexem.clone()));

        self.current_lexem = String::new();
        self.current_category = Lexeme::None;
        self.state = State::Start;
    }

    /// Pushes the next `char` in `self.code` to `self.CurrentLexeme`
    /// and iterates `self.index`.
    pub fn add_one(&mut self) {
        let c = self.curr_char();

        self.current_lexem.push(c);
        self.index += 1;
    }

    /// Iterates `self.index`, effectively dropping the next `char`
    /// of `self.code`.
    pub fn drop_one(&mut self) {
        self.index += 1;
    }

    /// Gets the `char` at `self.code[self.index]`.
    pub fn curr_char(&mut self) -> char {
        self.code.chars().nth(self.index).unwrap_or('\n')
    }

    /// Gets the `char` at `self.code[self.index + 1]`
    pub fn next_char(&mut self) -> char {
        self.code.chars().nth(self.index + 1).unwrap_or('\n')
    }
}
