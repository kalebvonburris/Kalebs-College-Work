//! # Lexer

use std::ops::RangeInclusive;

/// A state machine lexer that takes an input
/// block of code and returns a `Vec` of ordered tuple pairs.
pub struct Lexer {
    /// The entirety of the given code block.
    code: Vec<char>,
    /// The current string literal of the [`Lexeme`] being lexed.
    current_lexeme: String,
    /// The category of the current [`Lexeme`] being lexed.
    current_category: Lexeme,
    /// The index into the `code` `Vec`. Can never be `>= code.len()`.
    index: usize,
    /// The current [`State`] of the lexer.
    state: State,
    /// Storage for the [`Lexeme`]s found.
    found_lexems: Vec<(Lexeme, String)>,
}

/// The `State` of a [`Lexer`].
#[derive(Debug, PartialEq)]
pub(crate) enum State {
    Start,
    Letter,
    Num,
    Operator,
    Comment,
    End,
}

/// A given `Lexeme` according to the lexical specification.
#[derive(Debug, PartialEq, Clone)]
pub enum Lexeme {
    /// Invalid state: no [`Lexeme`].
    None,
    /// See [`KEYWORDS`].
    Keyword,
    /// A `String` that represents either a variable name
    /// or function name.
    Identifier,
    /// A literal numerical value, such as `1`, `2.5`, or `123.4E10`.
    NumericLiteral(NumericLiteral),
    /// An operator used by [`NumericLiterals`](NumericLiteral)s or
    /// variables.
    Operator,
    /// A possible piece of fluff, such as a semicolor (`';'`),
    /// open/close braces (`'{'`/`'}'`).
    Punctuation,
    /// Some sort of broken state/[`Lexeme`] with an attached
    /// [error](LexingError).
    Malformed(LexingError),
}

/// Different possible forms of a `NumericLiteral`.
#[derive(Debug, PartialEq, Clone)]
pub enum NumericLiteral {
    /// Whole integer values: `/[0-9]+/`.
    Integer,
    /// Basic `Float` values: `/([0-9]*.[0-9]+)|([0-9]+.[0-9]*)/`
    Float,
    /// Error value for a malformed [Float](NumericLiteral::Float).
    ///
    /// Typically, this is due to a case such as: `0.2.2.2`.
    MalformedFloat,
    /// A `Scientific` notation `NumericLiteral` value:
    /// `/[0-9]*.?[0-9]+(e|E)(+|-)?[0-9]+/`.
    Scientific,
}

#[derive(Debug, PartialEq, Clone)]
pub enum LexingError {
    NonLegalChar,
    KeywordUsed,
    NoLexemeFound,
    ImproperNumericLiteral,
}

/// All legal [`char`]s for the lexical specification.
///
/// These are ASCII `' '`` to ASCII `'~'`.
///
/// ```
/// use undefined_rs::lexer;
/// assert_eq!(' '..='~', lexer::LEGAL_CHARACTERS);
/// ```
pub const LEGAL_CHARACTERS: RangeInclusive<char> = ' '..='~';

/// All legal [`Keywords`](Lexeme::Keyword).
///
/// ```
/// use undefined_rs::lexer;
/// assert_eq!(&["begin", "end", "print"], lexer::KEYWORDS);
/// ```
pub const KEYWORDS: &[&str] = &["begin", "end", "print"];

/// All legal [`Operators`](Lexeme::Operator).
/// ```
/// use undefined_rs::lexer;
///
/// let operators = &[
///   "+", "-", "*", "/", "++", "--", ".", "=", "==", "+=", "-=", "*=", "/=",
/// ];
///
/// assert_eq!(operators, lexer::OPERATORS);
/// ```
pub const OPERATORS: &[&str] = &[
    "+", "-", "*", "/", "++", "--", ".", "=", "==", "+=", "-=", "*=", "/=",
];

impl Lexer {
    /// Creates a new [`Lexer`]
    ///
    /// Call [`Lexer::lex_input`] to get the desired output `Vec` of [`Lexeme`]s.
    pub fn new(s: String) -> Self {
        Self {
            code: s.chars().collect(),
            current_lexeme: String::new(),
            current_category: Lexeme::None,
            index: 0,
            state: State::Start,
            found_lexems: Vec::new(),
        }
    }

    /// Lexes the current `self.code` `String` into a `Vec<(Lexeme, String)>`.
    ///
    /// ```
    /// use undefined_rs::lexer::{
    ///     Lexer,
    ///     Lexeme,
    ///     NumericLiteral,
    /// };
    ///
    /// let mut lexer = Lexer::new("2".to_string());
    ///
    /// let expected_output = vec![
    ///     (Lexeme::NumericLiteral(NumericLiteral::Integer),
    ///     "2".to_string()),
    /// ];
    ///
    /// assert_eq!(lexer.lex_input(), expected_output);
    /// ```
    pub fn lex_input(&mut self) -> Vec<(Lexeme, String)> {
        while self.index < self.code.len() {
            /*dbg!(
                &self.current_category,
                &self.current_lexeme,
                &self.found_lexems
            );*/
            self.handle_state();
        }

        // Handle any hanging lexemes
        if self.state != State::Start {
            self.handle_state();
            self.handle_end();
        }

        self.found_lexems.clone()
    }

    /// Maps a given [`State`] to its related handler function.
    fn handle_state(&mut self) {
        match self.state {
            State::Start => self.handle_start(),
            State::Letter => self.handle_letter(),
            State::Num => self.handle_num(),
            State::Operator => self.handle_operator(),
            State::Comment => self.handle_comment(),
            State::End => self.handle_end(),
        }
    }

    /// Handles the state: [`State::Start`]
    ///
    /// Maps the given `curr_char` to a state for relevant lexing.
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

    /// Handles the state: [`State::Comment`]
    ///
    /// All comments start with `"/*"` and continue until
    /// "*/" is seen, or the `EOF`.
    fn handle_comment(&mut self) {
        if self.curr_char() == '*' && self.next_char() == '/' {
            self.drop_one();
            self.drop_one();
            self.state = State::Start;
        } else {
            self.drop_one();
        }
    }

    /// Handles the state: [`State::Letter`]
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

    /// Handles the state: [`State::NumericLiteral`]
    ///
    /// This is triggered after seeing a number while not in the
    /// [State::Letter](State::Letter) state. Usually lexes out a [`Lexeme::NumericLiteral`].
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

    /// Handles the state: [`State::Operator`]
    ///
    /// See [`OPERATORS`] for all valid operators.
    fn handle_operator(&mut self) {
        let mut op = self.current_lexeme.clone();

        op.push(self.curr_char());

        if OPERATORS.contains(&op.as_str()) {
            self.add_one();
            self.state = State::End;
            return;
        }

        // +/- state
        if self.current_lexeme == "+" || self.current_lexeme == "-" {
            // +/-[0-9]
            if self.curr_char().is_ascii_digit() {
                self.add_one();
                self.state = State::Num;
                self.current_category = Lexeme::NumericLiteral(NumericLiteral::Integer);
            }
            // +/-.[0-9]
            else if self.curr_char() == '.' && self.next_char().is_ascii_digit() {
                self.add_one();
                self.state = State::Num;
                self.current_category = Lexeme::NumericLiteral(NumericLiteral::Float);
            }
            // +/- only
            else {
                self.state = State::End;
            }
        } else {
            self.state = State::End;
        }
    }

    /// Handles the state: [`State::NumericLiteral(NumericLiteral::Scientific)`]
    ///
    /// All scientific literals must be in the form `/[0-9]*.?[0-9]+(e|E)-?[0-9]+/`.
    fn handle_scientific(&mut self) {
        // First thing after the 'e'/'E' isn't  a number
        if !self.curr_char().is_ascii_digit() && self.curr_char() != '-' {
            self.current_category = Lexeme::Malformed(LexingError::ImproperNumericLiteral);
            self.state = State::End;
            return;
        }

        if self.curr_char() == '-' {
            self.add_one();
        }

        while self.curr_char().is_ascii_digit() {
            self.add_one();
        }

        self.state = State::End;
    }

    /// Handles the state: [`State::End`]
    ///
    /// Pushes the `self.current_lexeme` and `self.current_category` onto
    /// the `self.found_lexems` [`Vec`].
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
        *self.code.get(self.index).unwrap_or(&' ')
    }

    /// Gets the `char` at `self.code[self.index + 1]`
    fn next_char(&mut self) -> char {
        *self.code.get(self.index + 1).unwrap_or(&' ')
    }
}
