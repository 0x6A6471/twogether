open Lwt.Syntax
open Ppx_yojson_conv_lib.Yojson_conv.Primitives

module Request = struct
  type t =
    { email : string
    ; password : string
    }
  [@@deriving yojson]
end

module Response = struct
  type t =
    { id : string
    ; name : string
    ; email : string
    ; password : string
    }
  [@@deriving yojson]

  let find_user ~email pool =
    let query =
      [%rapper
        get_opt
          {sql|
          SELECT @string{id}, @string{name}, @string{email}, @string{password}
          FROM users
          WHERE email = %string{email} 
          |sql}
          record_out]
    in
    let* result = Caqti_lwt.Pool.use (fun db -> query db ~email) pool in
    match result with
    | Ok (Some user) -> Lwt.return (Ok user)
    | Ok None -> Lwt.return (Error "User not found")
    | Error err -> Lwt.return (Error (Caqti_error.show err))
  ;;
end

let handler pool request =
  let* body = Dream.body request in
  Dream.log "%s" body;
  let body = Request.t_of_yojson (Yojson.Safe.from_string body) in
  let* user = Response.find_user ~email:body.email pool in
  match user with
  | Error err ->
    Dream.log "%s" err;
    Dream.json ~status:`Unauthorized {|{ "error": "invalid credentials" }|}
  | Ok user ->
    let hashed_password = Bcrypt.hash_of_string user.password in
    let verify_password = Bcrypt.verify body.password hashed_password in
    (match verify_password with
     | true ->
       Dream.log "putting session with user_id: %s" user.id;
       let* _ = Dream.put_session "user_id" user.id request in
       let user_json = Response.yojson_of_t user in
       Dream.json (Yojson.Safe.to_string user_json)
     | false ->
       Dream.json ~status:`Unauthorized {|{ "error": "invalid credentials" }|})
;;
