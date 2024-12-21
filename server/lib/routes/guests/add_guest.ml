open Lwt.Syntax

type t =
  { first_name : string
  ; last_name : string
  ; address_line_1 : string
  ; address_line_2 : string option
  ; city : string
  ; state : string
  ; zip : string
  ; country : string
  ; rsvp_status : string
  }
[@@deriving yojson]

let add_guest
      ~user_id
      ~first_name
      ~last_name
      ~address_line_1
      ~address_line_2
      ~city
      ~state
      ~zip
      ~country
      ~rsvp_status
      pool
  =
  let query =
    [%rapper
      execute
        {sql|INSERT INTO guests (user_id, first_name, last_name, address_line_1, address_line_2, city, state, zip, country, rsvp_status)
      VALUES (%string{user_id}, %string{first_name}, %string{last_name}, %string{address_line_1}, %string?{address_line_2}, %string{city}, %string{state}, %string{zip}, %string{country}, %string{rsvp_status})|sql}]
  in
  let* result =
    Caqti_lwt.Pool.use
      (fun db ->
         query
           db
           ~user_id
           ~first_name
           ~last_name
           ~address_line_1
           ~address_line_2
           ~city
           ~state
           ~zip
           ~country
           ~rsvp_status)
      pool
  in
  match result with
  | Ok _ -> Lwt.return (Ok ())
  | Error err -> Lwt.return (Error (`Database err))
;;

let handler pool request =
  let session = Dream.session "user_id" request in
  match session with
  | Some user_id ->
    let* body = Dream.body request in
    begin
      let guest = of_yojson (Yojson.Safe.from_string body) in
      match guest with
      | Ok guest ->
        let* result =
          add_guest
            ~user_id
            ~first_name:guest.first_name
            ~last_name:guest.last_name
            ~address_line_1:guest.address_line_1
            ~address_line_2:guest.address_line_2
            ~city:guest.city
            ~state:guest.state
            ~zip:guest.zip
            ~country:guest.country
            ~rsvp_status:guest.rsvp_status
            pool
        in
        begin
          match result with
          | Ok _ -> Dream.json {|{ "status": "ok" }|}
          | Error (`Database err) ->
            let error_msg = Caqti_error.show err in
            Dream.log "Database error in handler: %s" error_msg;
            Dream.json
              ~status:`Internal_Server_Error
              (Printf.sprintf {|{ "error": "Database error: %s" }|} error_msg)
        end
      | Error msg ->
        Dream.json
          ~status:`Bad_Request
          (Printf.sprintf {|{ "error": "Invalid JSON: %s" }|} msg)
    end
  | None -> Dream.json ~status:`Unauthorized {|{ "error": "unauthenticated" }|}
;;
