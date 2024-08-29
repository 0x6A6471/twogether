open Lwt.Syntax
open Ppx_yojson_conv_lib.Yojson_conv.Primitives

type t = { user_id : string } [@@deriving yojson]

let delete_guest ~id pool =
  let query =
    [%rapper
      execute
        {sql|
        DELETE FROM guests WHERE id = %string{id}
      |sql}]
  in
  let* result = Caqti_lwt.Pool.use (fun db -> query db ~id) pool in
  match result with
  | Ok _ -> Lwt.return_ok (Ok ())
  | Error _ -> Lwt.return_error (Error `Database_error)
;;

let handler pool request =
  let session = Dream.session "user_id" request in
  match session with
  | Some session_id ->
    (* TODO: need to make sure the user they're trying to delete is associated to the session user*)
    let id = Dream.param request "id" in
    let* user_id = Dream.body request in
    begin
      match user_id = session_id with
      | true ->
        let* _ = delete_guest ~id pool in
        Dream.json {|{ "status": "ok" }|}
      | false ->
        (* let* _ = Dream.invalidate_session request in *)
        Dream.json ~status:`Unauthorized {|{ "error": "unauthenticated" }|}
    end
  | None ->
    let* _ = Dream.invalidate_session request in
    Dream.json ~status:`Unauthorized {|{ "error": "unauthenticated" }|}
;;
