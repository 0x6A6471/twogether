open Lwt.Syntax
open Ppx_yojson_conv_lib.Yojson_conv.Primitives

type t =
  { first_name : string [@key "firstName"]
  ; last_name : string [@key "lastName"]
  ; email : string
  ; address_line_1 : string [@key "addressLine1"]
  ; address_line_2 : string option [@key "addressLine2"]
  ; city : string
  ; state : string
  ; zip : string
  ; country : string
  ; rsvp_status : string [@key "rsvpStatus"]
  }
[@@deriving yojson]

let add_guest
  ~user_id
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
        {sql|INSERT INTO guests (user_id, first_name, last_name, email, address_line_1, address_line_2, city, state, zip, country, rsvp_status)
      VALUES (%string{user_id}, %string{first_name}, %string{last_name}, %string{email}, %string{address_line_1}, %string?{address_line_2}, %string{city}, %string{state}, %string{zip}, %string{country}, %string{rsvp_status})|sql}]
  in
  let* result =
    Caqti_lwt.Pool.use
      (fun db ->
        query
          db
          ~user_id
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
  | Ok guest -> Lwt.return (Ok guest)
  | Error err -> Lwt.return (Error (`Database err))
;;

let handler pool request =
  let session = Dream.session "user_id" request in
  match session with
  | Some user_id ->
    Dream.log "%s" user_id;
    let* body = Dream.body request in
    Dream.log "%s" body;
    let guest = t_of_yojson (Yojson.Safe.from_string body) in
    let* _ =
      add_guest
        ~user_id
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
