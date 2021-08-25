(* Convert abstract syntax trees to generic trees of list of string *)

open Absyn

(* Helper functions *)

let name = Symbol.name
let map = List.map
let sprintf = Format.sprintf
let loc = Location.loc

(* Concatenate the lines of text in the node *)
let flat_nodes tree =
  Tree.map (String.concat "\n") tree

(* Make a tree *)
let mktree root children = Tree.mkt [root] children

(* Make a leaf tree *)
let mkleaf root = mktree root []

(* Convert a symbol to a general tree *)
let tree_of_symbol s = mktree (Symbol.name s) []

(* Convert a binary operator to a string *)
let stringfy_operator op =
  match op with
  | Plus -> "+"
  | LT -> "<"

(* Convert a type to a string *)
let stringify_type_ t =
  match t with
  | Int -> "int"
  | Bool -> "bool"

(* Convert an expression to a generic tree *)
let rec tree_of_exp exp =
  match exp with
  | IntExp x -> mkleaf (sprintf "IntExp %i" x)
  | VarExp x -> mkleaf (sprintf "VarExp %s" (name x))
  | OpExp (op, l, r) -> mktree (sprintf "OpExp %s" (stringfy_operator op)) [tree_of_lexp l; tree_of_lexp r]
  | IfExp (t, x, y) -> mktree "IfExp" [tree_of_lexp t; tree_of_lexp x; tree_of_lexp y]
  | CallExp (f, a) -> mktree (sprintf "CallExp %s" (name f)) (map tree_of_lexp a)
  | LetExp (x, i, e) -> mktree (sprintf "LetExp %s" (name x)) [tree_of_lexp i; tree_of_lexp e]

and tree_of_fundec (typeid, params, body) =
  mktree
    "Fun"
    [ tree_of_typeid typeid;
      mktree "Formals" (List.map tree_of_typeid params);
      tree_of_lexp body
    ]

and tree_of_program (Program fundecs) =
  mktree "Program" (List.map tree_of_lfundec fundecs)

and tree_of_typeid (type_, (_loc, id)) =
  mkleaf (sprintf "%s:%s" (name id) (stringify_type_ type_))

(* Convert an anotated ast to a generic tree *)
and tree_of_lsymbol (_, x) = tree_of_symbol x

and tree_of_lexp (_, x) = tree_of_exp x

and tree_of_lfundec (_, x) = tree_of_fundec x

and tree_of_lprogram (_, x) = tree_of_program x
