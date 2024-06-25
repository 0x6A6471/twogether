let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.sql_pool
       (* TODO: add to .env file and load DATABASE_URL from there *)
       ""
  @@ Dream.livereload
  @@ Dream.router
       [ Dream.get "/health" (fun _request ->
           let json_string = {|{ "status": "ok" }|} in
           let json = Yojson.Safe.from_string json_string in
           json |> Yojson.Safe.to_string |> Dream.json)
       ]
;;
