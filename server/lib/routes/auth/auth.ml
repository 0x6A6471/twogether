let routes pool =
  [ Dream.post "/api/auth/user" (Create_user.handler pool)
  ; Dream.post "/api/auth/user/verify" (Verify_user.handler pool)
    (* Add more routes here *)
  ]
;;
