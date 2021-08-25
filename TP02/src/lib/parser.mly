// parser.mly

%token                 EOF
%token <int>           LITINT
%token <Symbol.symbol> ID
%token                 PLUS
%token                 INT
%token                 LET
%token                 LT
%token                 COMMA
%token                 LPAREN
%token                 RPAREN
%token                 BOOL
%token                 IF
%token                 THEN
%token                 ELSE
%token                 EQ
%token                 IN

%%