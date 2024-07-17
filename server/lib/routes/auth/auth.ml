let routes pool =
  [ Dream.post "/api/auth/signup" (Signup.handler pool)
  ; Dream.post "/api/auth/login" (Login.handler pool)
  ; Dream.get "/api/auth/validate" (Validate.handler pool)
  ]
;;
