let find_month_name = function
  | 0 -> "January"
  | 1 -> "February"
  | 2 -> "March"
  | 3 -> "April"
  | 4 -> "May"
  | 5 -> "June"
  | 6 -> "July"
  | 7 -> "August"
  | 8 -> "September"
  | 9 -> "October"
  | 10 -> "November"
  | 11 -> "December"
  | _ -> invalid_arg "month_name"
;;

let format_date_str str =
  let open Js.Date in
  let date_obj = fromString str in
  let month = getMonth date_obj in
  let month_name = find_month_name (int_of_float month) in
  let day = getDate date_obj |> int_of_float in
  let year = getFullYear date_obj |> int_of_float in
  Printf.sprintf "%s %i, %i" month_name day year
;;
