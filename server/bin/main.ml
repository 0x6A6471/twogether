let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.livereload
  @@ Dream.router
       [ Dream.get "/health" (fun _request ->
           let json_string = {|{ "status": "ok" }|} in
           let json = Yojson.Safe.from_string json_string in
           json |> Yojson.Safe.to_string |> Dream.json)
       ]
;;
