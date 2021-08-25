// parser.mly

%{
  open Absyn
%}

%token                 EOF
%token <int>           LITINT
%token <Symbol.symbol> ID
%token                 PLUS
%token                 LT
%token                 EQ
%token                 COMMA
%token                 LPAREN
%token                 RPAREN
%token                 INT
%token                 BOOL
%token                 IF
%token                 THEN
%token                 ELSE
%token                 LET
%token                 IN

%start <lprogram> program

%right ELSE IN
%nonassoc LT
%left PLUS

%%

program:
    | s=nonempty_list(fn) EOF { $loc, Program (s) }
    ;

fn:
    | a=typeid LPAREN b=typeidlist RPAREN EQ e=exp { $loc, (a, b, e) }
    ;

typeid:
    | INT x=ID {Int, ($loc, x)}
    | BOOL x=ID {Bool, ($loc, x)}
    ;

typeidlist:
    | b=separated_nonempty_list(COMMA, typeid) { b }
    ;

exp:
    | c=LITINT {$loc, IntExp c}
    | c=ID {$loc, VarExp c}
    | e1=exp op=binop e2=exp {$loc, OpExp (op, e1, e2) }
    | IF e1=exp THEN e2=exp ELSE e3=exp {$loc, IfExp (e1, e2, e3) }
    | c=ID LPAREN d=explist RPAREN {$loc, CallExp (c, d)}
    | LET c=ID EQ e1=exp IN e2=exp {$loc, LetExp (c, e1, e2) }
    ;

explist:
    | b=separated_nonempty_list(COMMA, exp) { b }
    ;

%inline binop:
    | PLUS { Plus }
    | LT { LT }
    ;