open Lwt.Syntax
open Ppx_yojson_conv_lib.Yojson_conv.Primitives

type t =
  { id : string
  ; first_name : string
  ; last_name : string
  ; email : string
  ; address_line_1 : string
  ; address_line_2 : string
  ; city : string
  ; state : string
  ; zip : string
  ; country : string
  ; rsvp_status : string
  }
[@@deriving yojson]

let get_user_guests ~user_id pool =
  let query =
    [%rapper
      get_many
        {sql|
          SELECT @string{id}, @string{first_name}, @string{last_name}, @string{email},
          @string{address_line_1}, @string{address_line_2}, @string{city}, @string{state},
          @string{zip}, @string{country}, @string{rsvp_status}
          FROM guests WHERE user_id = %string{user_id}
        |sql}
        record_out]
  in
  let* result = Caqti_lwt.Pool.use (fun db -> query db ~user_id) pool in
  match result with
  | Ok guests -> Lwt.return guests
  | Error _err -> Lwt.return []
;;

let handler pool request =
  let session = Dream.session "user_id" request in
  match session with
  | Some user_id ->
    let* guests = get_user_guests ~user_id pool in
    let guests_json = `List (List.map yojson_of_t guests) in
    Dream.json (Yojson.Safe.to_string guests_json)
  | None ->
    let* guests =
      get_user_guests ~user_id:"7a1471c1-4a60-4b70-bf36-4f498f6dce5c" pool
    in
    let guests_json = `List (List.map yojson_of_t guests) in
    Dream.json (Yojson.Safe.to_string guests_json)
;;
