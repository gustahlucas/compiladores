let main =
  print_string "What is your name? ";
  let n = read_line () in  
  print_endline (Mylib.Hello.greeting n);
  print_string "In what year were you born? ";
  let a = read_int () in
  print_string "You are ";
  print_int (Mylib.Hello.get_age a);
  print_string " years old."; 