# Trivia

**Trivia** is a mini programming language intended for practicing some techiniques commonly found when implementing a compiler.

## Syntax analysis

The student should complete the definition of the **context free grammar** (in the notation used by menhir) for the Trivia language. See the language documentation in [`doc/source-language.pdf`](doc/source-language.pdf) for information about the structure of the language.

The missing rules are to be inserted into [`src/lib/parser.mly`](src/lib/parser.mly), which is the input used by menhir, the syntax analyser generator.

All tests in [`src/lib/test_parser.ml`](src/lib/test_parser.ml) should succeed.
