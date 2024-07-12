open Lwt.Syntax

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

let cors_middleware inner_handler req =
  let new_headers =
    [ "Allow", "OPTIONS, GET, HEAD, POST"
    ; "Access-Control-Allow-Origin", "http://localhost:5173"
    ; "Access-Control-Allow-Methods", "OPTIONS, GET, POST, DELETE, PUT"
    ; "Access-Control-Allow-Headers", "Content-Type, Accept"
    ; "Access-Control-Allow-Credentials", "true"
    ]
  in
  match Dream.method_ req with
  | `OPTIONS -> Dream.respond ~headers:new_headers ""
  | _ ->
    let* response = inner_handler req in
    let response_with_headers =
      List.fold_left
        (fun resp (key, value) ->
          Dream.add_header resp key value;
          resp)
        response
        new_headers
    in
    Lwt.return response_with_headers
;;

let () =
  Dream.run
  @@ Dream.logger
  (* @@ Dream.livereload *)
  @@ cors_middleware
  @@ Dream.sql_pool database_url
  @@ Dream.router
       ([ Dream.get "/health" (fun _request ->
            let json_string = {|{ "status": "ok" }|} in
            let json = Yojson.Safe.from_string json_string in
            json |> Yojson.Safe.to_string |> Dream.json)
        ]
        @ Auth.routes pool)
;;
