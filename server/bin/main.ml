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

let () =
  Dream.run
  @@ Dream.logger
  (* @@ Dream.livereload *)
  @@ Dream.sql_pool database_url
  @@ Dream.router
       ([ Dream.get "/health" (fun _request ->
            let json_string = {|{ "status": "ok" }|} in
            let json = Yojson.Safe.from_string json_string in
            json |> Yojson.Safe.to_string |> Dream.json)
        ]
        @ Auth.routes pool)
;;
