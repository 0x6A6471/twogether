open Lwt.Syntax

let get_user_guests ~session_id pool =
  let query =
    [%rapper
      get_many
        {sql|
          SELECT @string{id}, @string{user_id}, @string{first_name}, @string{last_name},
          @string{address_line_1}, @string?{address_line_2}, @string{city}, @string{state},
          @string{zip}, @string{country}, @string{rsvp_status}, @string{created_at}, @string{updated_at}
          FROM guests WHERE user_id = %string{session_id}
        |sql}
        function_out]
      Models.Guest.make
  in
  let* result = Caqti_lwt.Pool.use (fun db -> query db ~session_id) pool in
  match result with
  | Ok guests -> Lwt.return guests
  | Error _err -> Lwt.return []
;;

let handler pool request =
  let session = Dream.session "user_id" request in
  match session with
  | Some session_id ->
    let* guests = get_user_guests ~session_id pool in
    let guests_json = `List (List.map Models.Guest.to_yojson guests) in
    Dream.json (Yojson.Safe.to_string guests_json)
  | None -> Dream.json ~status:`Unauthorized {|{ "error": "unauthenticated" }|}
;;
