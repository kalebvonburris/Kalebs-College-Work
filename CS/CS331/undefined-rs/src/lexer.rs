//! # Lexer

pub struct Lexer {
    code: String,
    current_lexeme: String,
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
    Operator,
    Comment,
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
    NonLegalChar,
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
            current_lexeme: String::new(),
            current_category: Lexeme::None,
            index: 0,
            state: State::Start,
            found_lexems: Vec::new(),
        }
    }

    pub fn lex_input(&mut self) -> Vec<(Lexeme, String)> {
        while self.index <= self.code.len() {
            dbg!(
                &self.current_category,
                &self.current_lexeme,
                &self.found_lexems
            );
            match self.state {
                State::Start => self.handle_start(),
                State::Letter => self.handle_letter(),
                State::Num => self.handle_num(),
                State::Operator => self.handle_operator(),
                State::Comment => self.handle_comment(),
                State::End => self.handle_end(),
            }
        }

        self.found_lexems.clone()
    }

    fn handle_start(&mut self) {
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
            '+' | '-' | '=' | '*' | '.' | '/' => {
                // Comment - NOT an Operator
                if self.curr_char() == '/' && self.next_char() == '*' {
                    self.drop_one();
                    self.drop_one();
                    self.state = State::Comment;
                    return;
                }

                self.add_one();
                self.state = State::Operator;
                self.current_category = Lexeme::Operator;
            }
            //'\n' => self.drop_one(),
            _ => {
                if LEGAL_CHARACTERS.contains(&self.curr_char()) {
                    self.add_one();
                    self.state = State::End;
                    self.current_category = Lexeme::Punctuation;
                } else {
                    self.add_one();
                    self.state = State::End;
                    self.current_category = Lexeme::Malformed(LexingError::NonLegalChar);
                }
            }
        };
    }

    fn handle_comment(&mut self) {
        if self.curr_char() != '*' && self.next_char() != '/' {
            self.drop_one();
        } else {
            self.drop_one();
            self.drop_one();
            self.state = State::Start;
        }
    }

    fn handle_letter(&mut self) {
        if self.curr_char().is_ascii_alphanumeric() || self.curr_char() == '_' {
            self.add_one();
        } else {
            self.state = State::End;
            if KEYWORDS.contains(&self.current_lexeme.as_str()) {
                self.current_category = Lexeme::Keyword;
            } else {
                self.current_category = Lexeme::Identifier;
            }
        }
    }

    fn handle_num(&mut self) {
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

    fn handle_operator(&mut self) {
        let mut op = self.current_lexeme.clone();

        op.push(self.curr_char());

        if OPERATORS.contains(&op.as_str()) {
            self.add_one();
        }

        if self.current_lexeme == "+" || self.current_lexeme == "-" {
            if self.curr_char().is_ascii_digit() {
                self.add_one();
                self.state = State::Num;
                self.current_category = Lexeme::NumericLiteral(NumericLiteral::Integer);
            } else if self.curr_char() == '.' && self.next_char().is_ascii_digit() {
                self.add_one();
                self.state = State::Num;
                self.current_category = Lexeme::NumericLiteral(NumericLiteral::Float);
            } else {
                self.state = State::End;
            }
        } else {
            self.state = State::End;
        }
    }

    fn handle_scientific(&mut self) {
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

    fn handle_end(&mut self) {
        if self.current_category == Lexeme::NumericLiteral(NumericLiteral::MalformedFloat) {
            self.current_category = Lexeme::Malformed(LexingError::ImproperNumericLiteral);
        }

        self.found_lexems
            .push((self.current_category.clone(), self.current_lexeme.clone()));

        self.current_lexeme = String::new();
        self.current_category = Lexeme::None;
        self.state = State::Start;
    }

    /// Pushes the next `char` in `self.code` to `self.CurrentLexeme`
    /// and iterates `self.index`.
    fn add_one(&mut self) {
        let c = self.curr_char();

        self.current_lexeme.push(c);
        self.index += 1;
    }

    /// Iterates `self.index`, effectively dropping the next `char`
    /// of `self.code`.
    fn drop_one(&mut self) {
        self.index += 1;
    }

    /// Gets the `char` at `self.code[self.index]`.
    fn curr_char(&mut self) -> char {
        self.code.chars().nth(self.index).unwrap_or(' ')
    }

    /// Gets the `char` at `self.code[self.index + 1]`
    fn next_char(&mut self) -> char {
        self.code.chars().nth(self.index + 1).unwrap_or(' ')
    }
}
