# Trivia

**Trivia** is a mini programming language intended for practicing some techiniques commonly found when implementing a compiler.

## Lexical analysis

The student should complete the definition of the **lexical rules** for the Trivia language. See the language documentation in [`doc/source-language.pdf`](doc/source-language.pdf) for information about the structure of the language.

The missing rules are to be inserted into [`src/lib/lexer.mll`](src/lib/lexer.mll), which is the input used bye the lexical analyser generator.

Any new terminal symbol (token) should be declared in [`src/lib/parser.mly`](src/lib/parser.mly), which is the input used by the parser generator.

All tests in [`src/lib/test_lexer.ml`](src/lib/test_lexer.ml) should succeed.
