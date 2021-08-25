(* absyn.ml *)

type symbol = Symbol.symbol
  [@@deriving show]

type 'a loc = 'a Location.loc
  [@@deriving show]


type operator =
  | Plus
  | LT
  [@@deriving show]

type exp =
  | IntExp of int
  | VarExp of symbol
  | OpExp of operator * lexp * lexp
  | IfExp of lexp * lexp * lexp
  | CallExp of symbol * lexp list
  | LetExp of symbol * lexp * lexp
  [@@deriving show]

and program =
  | Program of lfundec list
  [@@deriving show]

and fundec = typeid * typeid list * lexp
  [@@deriving show]

and type_ =
  | Int
  | Bool
  [@@deriving show]

and typeid = type_ * lsymbol
  [@@deriving show]


and lsymbol = symbol loc
  [@@deriving show]

and lexp = exp loc
  [@@deriving show]

and lfundec = fundec loc
  [@@deriving show]

and lprogram = program loc
  [@@deriving show]
