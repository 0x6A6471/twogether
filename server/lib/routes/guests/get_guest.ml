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
  ; created_at : string
  }
[@@deriving yojson]

let get_guest ~id pool =
  let query =
    [%rapper
      get_opt
        {sql|
          SELECT @string{id}, @string{first_name}, @string{last_name}, @string{email},
          @string{address_line_1}, @string{address_line_2}, @string{city}, @string{state},
          @string{zip}, @string{country}, @string{rsvp_status}, @string{created_at}
          FROM guests WHERE id = %string{id}
        |sql}
        record_out]
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
    let guest_json = yojson_of_t guest in
    Dream.json (Yojson.Safe.to_string guest_json)
  | None -> Dream.json ~status:`Not_Found {|{"error": "Guest not found"}|}
;;
