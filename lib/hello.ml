(* implementation of the Hello module *)
let hello = "Hello"

let greeting name =
  hello ^ ", " ^ name ^ "!"

let just_now = Ptime_clock.now()
let ((current_year, _, _), _) = Ptime.to_date_time just_now

let get_age age =
  current_year - age  