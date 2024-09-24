open Utils

type rsvp_status =
  [ `not_invited
  | `invited
  | `accepted
  | `declined
  ]

type t =
  { id : string
  ; user_id : string
  ; first_name : string
  ; last_name : string
  ; email : string
  ; address_line_1 : string
  ; address_line_2 : string option
  ; city : string
  ; state : string
  ; zip : string
  ; country : string
  ; rsvp_status : rsvp_status
  ; created_at : string
  ; updated_at : string
  }

module Decode = struct
  let rsvp_status json =
    Json.Decode.(
      json
      |> string
      |> function
      | "not_invited" -> `not_invited
      | "invited" -> `invited
      | "accepted" -> `accepted
      | "declined" -> `declined
      | _ -> failwith "Invalid rsvp_status")
  ;;

  let guest json =
    Json.Decode.(
      json
      |> fun json ->
      let id = field "id" string json in
      let user_id = field "email" string json in
      let first_name = field "first_name" string json in
      let last_name = field "last_name" string json in
      let email = field "email" string json in
      let address_line_1 = field "address_line_1" string json in
      let address_line_2 = optional (field "address_line_2" string) json in
      let city = field "city" string json in
      let state = field "state" string json in
      let zip = field "zip" string json in
      let country = field "country" string json in
      let rsvp_status = field "rsvp_status" rsvp_status json in
      let created_at = field "created_at" string json in
      let updated_at = field "updated_at" string json in
      { id
      ; user_id
      ; first_name
      ; last_name
      ; email
      ; address_line_1
      ; address_line_2
      ; city
      ; state
      ; zip
      ; country
      ; rsvp_status
      ; created_at
      ; updated_at
      })
  ;;

  let guests json = Json.Decode.array guest json
end

let get_user_guests _ = Fetcher.fetch "/api/guests" ~decoder:Decode.guests

let use_guests _ =
  let open ReactQuery.Query in
  useQuery
    (queryOptions
       ~queryKey:(ReactQuery.Utils.queryKey1 "posts")
       ~queryFn:get_user_guests
       ())
;;
