let test_hello () =
  Alcotest.(check string) "same string" (Mylib.Hello.greeting "John Doe") "Hello, John Doe!"

let test_age () =
  Alcotest.(check int) "same int" (Mylib.Hello.get_age 2000) 21

let () =
  let open Alcotest in
  run "Hello" [ ("world", [ test_case "Equal" `Quick test_hello ]);
                ("age",   [ test_case "Equal" `Quick test_age ]) ]
