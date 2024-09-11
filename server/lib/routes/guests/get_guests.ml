open Lwt.Syntax

type t = Models.Guest.t

let get_user_guests ~session_id pool =
  let query =
    [%rapper
      get_many
        {sql|
          SELECT @string{id}, @string{user_id}, @string{first_name}, @string{last_name}, @string{email},
          @string{address_line_1}, @string?{address_line_2}, @string{city}, @string{state},
          @string{zip}, @string{country}, @string{rsvp_status}, @string{created_at}, @string{updated_at}
          FROM guests WHERE user_id = %string{session_id}
        |sql}
        function_out]
  in
  let* result = Caqti_lwt.Pool.use (fun db -> query db ~session_id) pool in
  match result with
  | Ok guests -> Lwt.return guests
  | Error _err -> Lwt.return []
;;

(* ('a list, 'b) result *)
(* ('a list, [> Caqti_error.call_or_retrieve ]) result *)

let handler _pool request =
  let session = Dream.session "user_id" request in
  match session with
  | Some session_id ->
    Dream.log "SESSION_ID = %s" session_id;
    (* let* guests = get_user_guests ~session_id pool in *)
    (* let guests_json = `List (List.map yojson_of_t guests) in *)
    (* Dream.json (Yojson.Safe.to_string guests_json) *)
    assert false
  | None -> Dream.json ~status:`Unauthorized {|{ "error": "unauthenticated" }|}
;;
