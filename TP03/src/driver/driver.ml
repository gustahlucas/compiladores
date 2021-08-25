(* Driver *)

let main () =
  let lexbuf =
    match Sys.argv with
    | [| _; input |] ->
       let lexbuf = Lexing.from_channel (open_in input) in
       Lexing.set_filename lexbuf input;
       lexbuf
    | _ ->
       Lexing.from_channel stdin
  in
  
  try
    let ast = Parser.program Lexer.token lexbuf in
    print_endline "Abstract syntax tree:";
    print_endline "============================================================";
    print_endline (Absyn.show_lprogram ast);
    print_endline "============================================================";
    let tree = Absyntree.flat_nodes (Absyntree.tree_of_lprogram ast) in
    let boxtree = Tree.box_of_tree tree in
    print_endline (Box.string_of_box boxtree);
    print_endline "============================================================";
    print_endline (Tree.string_of_tree tree);
    print_endline "============================================================"
   with
  | Error.Error (loc, msg) ->
     Format.printf "%a error: %s\n" Location.pp_location loc msg;
     exit 1
  | Parser.Error ->
     Format.printf "%a error: syntax\n" Location.pp_position lexbuf.Lexing.lex_curr_p;
     exit 2

let _ = main ()
