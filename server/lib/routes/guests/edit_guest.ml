open Lwt.Syntax
(*
   i wonder if we can make a models/guest.ml with all these
  properties and then maybe we can use that to generate the
  json and the sql queries 

  if we can't just use a single model i wonder if we could make something like this:
  type t =
    { id : t.id
    ; user_id : t.user_id
    ; first_name : t.first_name
    // only defining the properties that you need
    }
*)

type t = Models.Guest.t

let edit_guest
  ~id
  ~first_name
  ~last_name
  ~email
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
        {sql|UPDATE guests 
        SET first_name = %string{first_name}, last_name = %string{last_name}, 
        email = %string{email}, address_line_1 = %string{address_line_1}, 
        address_line_2 = %string?{address_line_2}, city = %string{city}, 
        state = %string{state}, zip = %string{zip}, country = %string{country}, 
        rsvp_status = %string{rsvp_status}, updated_at = NOW()
        WHERE id = %string{id}
      |sql}]
  in
  let* result =
    Caqti_lwt.Pool.use
      (fun db ->
        query
          db
          ~id
          ~first_name
          ~last_name
          ~email
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
    let guest = Models.Guest.of_yojson (Yojson.Safe.from_string body) in
    begin
      match guest with
      | Ok guest ->
        if user_id <> guest.user_id
        then Dream.json ~status:`Unauthorized {|{ "error": "unauthenticated" }|}
        else
          let* _ =
            edit_guest
              ~id:guest.id
              ~first_name:guest.first_name
              ~last_name:guest.last_name
              ~email:guest.email
              ~address_line_1:guest.address_line_1
              ~address_line_2:guest.address_line_2
              ~city:guest.city
              ~state:guest.state
              ~zip:guest.zip
              ~country:guest.country
              ~rsvp_status:guest.rsvp_status
              pool
          in
          Dream.json {|{ "status": "ok" }|}
      | Error msg ->
        Dream.json
          ~status:`Bad_Request
          (Printf.sprintf {|{ "error": "Invalid JSON: %s" }|} msg)
    end
  | None -> Dream.json ~status:`Unauthorized {|{ "error": "unauthenticated" }|}
;;
