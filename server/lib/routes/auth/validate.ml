open Lwt.Syntax
open Ppx_yojson_conv_lib.Yojson_conv.Primitives

module Request = struct
  type t =
    { id : string
    ; email : string
    ; name : string
    }
  [@@deriving yojson]

  let find_user_by_id id pool =
    let query =
      [%rapper
        get_one
          {sql| SELECT @string{id}, @string{email}, @string{name} FROM users WHERE id = %string{id} |sql}
          record_out]
    in
    let* result = Caqti_lwt.Pool.use (fun db -> query db ~id) pool in
    match result with
    | Ok user -> Lwt.return (Some user)
    | Error _ -> Lwt.return None
  ;;
end

let handler pool request =
  let session = Dream.session "user_id" request in
  match session with
  | Some user_id ->
    Dream.log "%s" user_id;
    let* user = Request.find_user_by_id user_id pool in
    begin
      match user with
      | Some user ->
        let user_json = Request.yojson_of_t user in
        Dream.json (Yojson.Safe.to_string user_json)
      | None ->
        let* _ = Dream.invalidate_session request in
        Dream.json ~status:`Unauthorized {|{ "error": "user not found" }|}
    end
  | None ->
    Dream.log "No active session.";
    let* _ = Dream.invalidate_session request in
    Dream.json ~status:`Unauthorized "{ \"error\": \"No active session.\" }"
;;
