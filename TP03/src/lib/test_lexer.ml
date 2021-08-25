(* inline expect tests for the scanner *)

let scan_string s =
  let lexbuf = Lexing.from_string s in
  let rec loop () =
    let tok = Lexer.token lexbuf in
    Format.printf
      "%a %s\n%!"
      Location.pp_location
      (Location.curr_loc lexbuf)
      (Lexer.show_token tok);
    match tok with
    | Parser.EOF -> ()
    | _ -> loop ()
  in
  try loop ()
  with
  | Error.Error (loc, msg) ->
     Format.printf "%a error: %s\n" Location.pp_location loc msg

let%expect_test "spaces" =
  scan_string " \n\t   \n  ";
  [%expect{| :3.2-3.2 Parser.EOF |}]

let%expect_test "integer literals" =
  scan_string "27348";
  [%expect{|
    :1.0-1.5 (Parser.LITINT 27348)
    :1.5-1.5 Parser.EOF |}];

  (* integer literal has no signal *)
  scan_string "-27348";
  [%expect{| :1.0-1.1 error: illegal character '-' |}];

  scan_string "+27348";
  [%expect{|
    :1.0-1.1 Parser.PLUS
    :1.1-1.6 (Parser.LITINT 27348)
    :1.6-1.6 Parser.EOF |}]

let%expect_test "types" =
  scan_string "int";
  [%expect{|
    :1.0-1.3 Parser.INT
    :1.3-1.3 Parser.EOF |}];
  scan_string "bool";
  [%expect{|
    :1.0-1.4 Parser.BOOL
    :1.4-1.4 Parser.EOF |}]

let%expect_test "let expressions" =
  scan_string "let in";
  [%expect{|
    :1.0-1.3 Parser.LET
    :1.4-1.6 Parser.IN
    :1.6-1.6 Parser.EOF |}]

let%expect_test "if expressions" =
  scan_string "if then else";
  [%expect{|
    :1.0-1.2 Parser.IF
    :1.3-1.7 Parser.THEN
    :1.8-1.12 Parser.ELSE
    :1.12-1.12 Parser.EOF |}]

let%expect_test "identifiers" =
  scan_string "Idade alfa15 beta_2";
  [%expect{|
    :1.0-1.5 (Parser.ID "Idade")
    :1.6-1.12 (Parser.ID "alfa15")
    :1.13-1.19 (Parser.ID "beta_2")
    :1.19-1.19 Parser.EOF |}];

  (* invalid identifier *)
  scan_string "_altura";
  [%expect{| :1.0-1.1 error: illegal character '_' |}];

  scan_string "5x";
  [%expect{|
    :1.0-1.1 (Parser.LITINT 5)
    :1.1-1.2 (Parser.ID "x")
    :1.2-1.2 Parser.EOF |}]

let%expect_test "binary operators" =
  scan_string "+ <";
  [%expect{|
    :1.0-1.1 Parser.PLUS
    :1.2-1.3 Parser.LT
    :1.3-1.3 Parser.EOF |}]

let%expect_test "punctuations" =
  scan_string "( ) , =";
  [%expect{|
    :1.0-1.1 Parser.LPAREN
    :1.2-1.3 Parser.RPAREN
    :1.4-1.5 Parser.COMMA
    :1.6-1.7 Parser.EQ
    :1.7-1.7 Parser.EOF |}]

let%expect_test "program" =
  scan_string {|
               int sum(int a, int b) =
                 if a < b then
                   a + sum(a + 1, b)
                 else
                   0
               int main(int x) =
                 let y = x + 1 in sum(0, y)
               |};
  [%expect{|
    :2.15-2.18 Parser.INT
    :2.19-2.22 (Parser.ID "sum")
    :2.22-2.23 Parser.LPAREN
    :2.23-2.26 Parser.INT
    :2.27-2.28 (Parser.ID "a")
    :2.28-2.29 Parser.COMMA
    :2.30-2.33 Parser.INT
    :2.34-2.35 (Parser.ID "b")
    :2.35-2.36 Parser.RPAREN
    :2.37-2.38 Parser.EQ
    :3.17-3.19 Parser.IF
    :3.20-3.21 (Parser.ID "a")
    :3.22-3.23 Parser.LT
    :3.24-3.25 (Parser.ID "b")
    :3.26-3.30 Parser.THEN
    :4.19-4.20 (Parser.ID "a")
    :4.21-4.22 Parser.PLUS
    :4.23-4.26 (Parser.ID "sum")
    :4.26-4.27 Parser.LPAREN
    :4.27-4.28 (Parser.ID "a")
    :4.29-4.30 Parser.PLUS
    :4.31-4.32 (Parser.LITINT 1)
    :4.32-4.33 Parser.COMMA
    :4.34-4.35 (Parser.ID "b")
    :4.35-4.36 Parser.RPAREN
    :5.17-5.21 Parser.ELSE
    :6.19-6.20 (Parser.LITINT 0)
    :7.15-7.18 Parser.INT
    :7.19-7.23 (Parser.ID "main")
    :7.23-7.24 Parser.LPAREN
    :7.24-7.27 Parser.INT
    :7.28-7.29 (Parser.ID "x")
    :7.29-7.30 Parser.RPAREN
    :7.31-7.32 Parser.EQ
    :8.17-8.20 Parser.LET
    :8.21-8.22 (Parser.ID "y")
    :8.23-8.24 Parser.EQ
    :8.25-8.26 (Parser.ID "x")
    :8.27-8.28 Parser.PLUS
    :8.29-8.30 (Parser.LITINT 1)
    :8.31-8.33 Parser.IN
    :8.34-8.37 (Parser.ID "sum")
    :8.37-8.38 Parser.LPAREN
    :8.38-8.39 (Parser.LITINT 0)
    :8.39-8.40 Parser.COMMA
    :8.41-8.42 (Parser.ID "y")
    :8.42-8.43 Parser.RPAREN
    :9.15-9.15 Parser.EOF |}]
