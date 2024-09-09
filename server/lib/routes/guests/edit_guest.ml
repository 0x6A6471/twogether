open Lwt.Syntax
open Ppx_yojson_conv_lib.Yojson_conv.Primitives

type t =
  { id : string
  ; user_id : string (*[@key "userId"]*)
  ; first_name : string (*[@key "firstName"]*)
  ; last_name : string (*[@key "lastName"]*)
  ; email : string
  ; address_line_1 : string (*[@key "addressLine1"]*)
  ; address_line_2 : string option (*[@key "addressLine2"]*)
  ; city : string
  ; state : string
  ; zip : string
  ; country : string
  ; rsvp_status : string (*[@key "rsvpStatus"]*)
  ; created_at : string option (*[@key "rsvpStatus"]*)
  }
[@@deriving yojson]

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
    Dream.log "Received body: %s" body;
    let guest = t_of_yojson (Yojson.Safe.from_string body) in
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
  | None -> Dream.json ~status:`Unauthorized {|{ "error": "unauthenticated" }|}
;;
