open Lwt.Syntax

let get_guest ~id pool =
  let query =
    [%rapper
      get_opt
        {sql|
          SELECT @string{id}, @string{user_id}, @string{first_name}, @string{last_name},
          @string{address_line_1}, @string?{address_line_2}, @string{city}, @string{state},
          @string{zip}, @string{country}, @string{rsvp_status}, @string{created_at}, @string{updated_at} 
          FROM guests WHERE id = %string{id}
        |sql}
        function_out]
      Models.Guest.make
  in
  let* result = Caqti_lwt.Pool.use (fun db -> query db ~id) pool in
  match result with
  | Ok guest -> begin
    match guest with
    | Some guest -> Lwt.return (Some guest)
    | _ -> Lwt.return None
  end
  | Error _ -> Lwt.return None
;;

let handler pool request =
  let id = Dream.param request "id" in
  let* opt_guest = get_guest ~id pool in
  match opt_guest with
  | Some guest ->
    let guest_json = Models.Guest.to_yojson guest in
    Dream.json (Yojson.Safe.to_string guest_json)
  | None -> Dream.json ~status:`Not_Found {|{"error": "Guest not found"}|}
;;
