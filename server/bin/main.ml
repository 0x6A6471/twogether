open Lwt.Syntax
open Ppx_yojson_conv_lib.Yojson_conv.Primitives

let get_required_env var =
  match Stdlib.Sys.getenv var with
  | "" -> Fmt.failwith "Empty $%s" var
  | value -> value
  | exception _ -> Fmt.failwith "Missing $%s" var
;;

(* Load required environment variables *)
let () = Dotenv.export () |> ignore
let database_url = get_required_env "DATABASE_URL"

let init_pool () =
  let uri = Uri.of_string database_url in
  match Caqti_lwt.connect_pool ~max_size:10 uri with
  | Ok pool -> pool
  | Error err -> failwith (Caqti_error.show err)
;;

let pool = init_pool ()

type t =
  { id : int
  ; email : string
  }
[@@deriving yojson]

let get_user uid pool =
  let query =
    [%rapper
      get_one
        {sql| SELECT @int{id}, @string{email} FROM users WHERE id = %int{uid} |sql}
        record_out]
  in
  let* result = Caqti_lwt.Pool.use (fun db -> query db ~uid) pool in
  match result with
  | Ok user -> Lwt.return (Some user)
  | Error _ -> Lwt.return None
;;

let () =
  Dream.run
  @@ Dream.logger
  (* @@ Dream.livereload *)
  @@ Dream.sql_pool database_url
  @@ Dream.router
       [ Dream.get "/health" (fun _request ->
           let json_string = {|{ "status": "ok" }|} in
           let json = Yojson.Safe.from_string json_string in
           json |> Yojson.Safe.to_string |> Dream.json)
       ; Dream.get "/users" (fun _request ->
           let* user = get_user 1 pool in
           match user with
           | Some u ->
             let user_json = yojson_of_t u in
             Dream.json (Yojson.Safe.to_string user_json)
           | None -> assert false)
       ]
;;
