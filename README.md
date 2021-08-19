# Welcome

Working with a simple OCaml project using `opam` and `dune`.

This project implements a library and an application to greet the user with a message.

There is a video explaining the project in the Moodle virtual classroom for the course. Watch it.

## Exercise

Modify the project to add a question to the user, asking his year of birth, read the answer, and then display the user age.

You will need an aditional library to compute the age of the user, because the standard library does not have this functionality. Use the Use the library [`ptime`](https://erratique.ch/software/ptime/doc/Ptime.html), which has platform independent support for POSIX time.

- With the help of `opam`, install the `ptime` package in your system, if needed.
- Modify the `dune-project` to add a dependence on the package `ptime` to the project.
- Modify the `lib/dune` file to list the dependence libraries `ptime` and `ptime.clock.os` in the `library` stanza:
  ``` dune
    (libraries ptime ptime.clock.os)
  ```
- Add a function `get_age` to the module `Mylib.Hello`.
  - This function should returns the number of years from a given year to the current year.
  - Use the library [`ptime`](https://erratique.ch/software/ptime/doc/Ptime.html) to handle dates:
     - `Ptime_clock.now` can be used to get the current POSIX timestamp.
     - `Ptime.to_date_time` can be used to get the date and time of a given timestamp.
     - Use pattern matching to get the year in the result of `Ptime.to_date_time`. Something like:
       ``` ocaml
       let just_now = Ptime_clock.now ()
       let ((current_year, _, _), _) = Ptime.to_date_time just_now
       ```
  - Do not forget to add the new function to the interface of the module `Mylib.Hello`.
- Modify the application to:
  - ask the year of birth of the user,
  - read the answer, and
  - calculate and print the age
- Build and test the application.
- When ready, submit your solution to github classroom.
