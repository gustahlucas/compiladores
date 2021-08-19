(* inline expectation test for he library *)

let%expect_test "greeting" =
  print_string (Hello.greeting "world");
  [%expect{|
    Hello, world!
  |}]

let%expect_test "age" =
  print_int (Hello.get_age 2000);
  [%expect{|
    21
  |}]
