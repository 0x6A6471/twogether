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

  let get_user ~email pool =
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
    | Error _ -> Lwt.return (Error "Database error")
  ;;
end

let handler pool request =
  let* body = Dream.body request in
  Dream.log "Request body: %s" body;
  let body = Request.t_of_yojson (Yojson.Safe.from_string body) in
  let* user = Response.get_user ~email:body.email pool in
  match user with
  | Error _ -> Dream.json {|{ "error": "invalid credentials" }|}
  | Ok user ->
    let hashed_password = Bcrypt.hash_of_string user.password in
    let verify_password = Bcrypt.verify body.password hashed_password in
    (match verify_password with
     | true ->
       let user_json = Response.yojson_of_t user in
       Dream.json (Yojson.Safe.to_string user_json)
     | false -> Dream.json {|{ "error": "invalid_credentials" }|})
;;
