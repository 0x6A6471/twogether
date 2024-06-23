let () =
  Dream.run
  @@ Dream.logger
  @@ Dream.livereload
  @@ Dream.router
       [ Dream.get "/" (fun _ -> Dream.html "Hello, world!")
       ; Dream.get "/:word" (fun request ->
           Dream.html (Dream.param request "word"))
       ]
;;
