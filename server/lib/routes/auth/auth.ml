let routes pool =
  [ Dream.post "/api/auth/signup" (Signup.handler pool)
  ; Dream.post "/api/auth/login" (Login.handler pool)
  ; Dream.post "/api/auth/logout" Logout.handler
  ; Dream.get "/api/auth/validate" (Validate.handler pool)
  ]
;;
