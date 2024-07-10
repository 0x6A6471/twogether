open Lwt.Syntax
open Ppx_yojson_conv_lib.Yojson_conv.Primitives

type t =
  { name : string
  ; email : string
  ; password : string
  }
[@@deriving yojson]

let create_user ~name ~email ~password pool =
  let query =
    [%rapper
      execute
        {sql|
      INSERT INTO users (name, email, password)
      VALUES (%string{name}, %string{email}, %string{password})
      |sql}]
  in
  let* result =
    Caqti_lwt.Pool.use (fun db -> query db ~name ~email ~password) pool
  in
  match result with
  | Ok _ -> Lwt.return (Ok ())
  | Error err -> Lwt.return (Error (Caqti_error.show err))
;;

let handler _pool request =
  let* body = Dream.body request in
  Dream.log "Request body: %s" body;
  let body = t_of_yojson (Yojson.Safe.from_string body) in
  let default = Bcrypt.hash_of_string "users_hashed_password_here" in
  let verify_password = Bcrypt.verify body.password default in
  match verify_password with
  | true -> Dream.json {|{ "status": "ok" }|}
  | false -> Dream.json {|{ "error": "invalid_credentials" }|}
;;
