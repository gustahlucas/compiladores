{
  module L = Lexing

  type token = [%import: Parser.token] [@@deriving show]

  let illegal_character loc char =
    Error.error loc "illegal character '%c'" char
}

let spaces = [' ' '\t']+
let digit = ['0'-'9']
let integer = digit+
let letter = ['a'-'z' 'A'-'Z']
let underline = '_'
let identifier = letter (letter | digit | underline)*

rule token = parse
  | spaces            { token lexbuf }
  | '\n'              { L.new_line lexbuf; token lexbuf }
  | integer as lxm    { LITINT (int_of_string lxm) }
  | '+'               { PLUS }
  | '<'               { LT }
  | '='               { EQ }
  | ','               { COMMA }
  | '('               { LPAREN }
  | ')'               { RPAREN }
  | "in"              { IN }
  | "let"             { LET }
  | "int"             { INT }
  | "bool"            { BOOL }
  | "if"              { IF }
  | "then"            { THEN }
  | "else"            { ELSE }
  | identifier as lxm { ID (Symbol.symbol lxm) }
  | eof               { EOF }
  | _                 { illegal_character (Location.curr_loc lexbuf) (L.lexeme_char lexbuf 0) }
