val get : string -> decoder:(Js.Json.t -> 'a) -> 'a Js.Promise.t

val req_with_body
  :  string
  -> method_:Fetch.requestMethod
  -> payload:Js.Json.t Js.dict
  -> Js.Json.t Js.Promise.t
