open Lwt.Syntax

let handler request =
  let* _ = Dream.invalidate_session request in
  Dream.json "{|{ \"status\": \"ok\" }|}"
;;
