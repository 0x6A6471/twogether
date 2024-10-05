open Lwt.Syntax

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
    let id = Dream.param request "id" in
    let* body = Dream.body request in
    let json = Yojson.Basic.from_string body in
    (try
       let user_id =
         Yojson.Basic.Util.member "user_id" json |> Yojson.Basic.Util.to_string
       in
       begin
         match user_id = session_id with
         | true ->
           let* _ = delete_guest ~id pool in
           Dream.json {|{ "status": "ok" }|}
         | false ->
           Dream.json ~status:`Unauthorized {|{ "error": "unauthenticated" }|}
       end
     with
     | Yojson.Json_error _ ->
       Dream.json ~status:`Bad_Request {|{ "error": "invalid json" }|})
  | None ->
    let* _ = Dream.invalidate_session request in
    Dream.json ~status:`Unauthorized {|{ "error": "unauthenticated" }|}
;;
