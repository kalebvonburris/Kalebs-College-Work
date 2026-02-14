//! # Parser

use crate::lexer::Lexeme;

struct Parser {}

struct AST {
    tree: Vec<ASTNode>,
}

struct ASTNode {
    children: Vec<ASTNode>,
}

enum ASTValue {
    Leaf((ASTCategory, String)),
    Ast(AST),
}

enum ASTCategory {}
