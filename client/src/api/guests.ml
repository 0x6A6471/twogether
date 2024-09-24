open Utils

external api_url : string = "import.meta.env.VITE_API_URL"

type t =
  { id : string
  ; user_id : string [@key "userId"]
  ; first_name : string [@key "firstName"]
  ; last_name : string [@key "lastName"]
  ; email : string
  ; address_line_1 : string [@key "addressLine1"]
  ; address_line_2 : string option [@key "addressLine2"]
  ; city : string
  ; state : string
  ; zip : string
  ; country : string
  ; rsvp_status : string [@key "rsvpStatus"]
  ; created_at : string [@key "createdAt"]
  ; updated_at : string [@key "updatedAt"]
  }

module Decode = struct
  let guest json =
    Json.Decode.(
      json
      |> fun json ->
      let id = field "id" string json in
      let user_id = field "email" string json in
      let first_name = field "firstName" string json in
      let last_name = field "lastName" string json in
      let email = field "email" string json in
      let address_line_1 = field "addressLine1" string json in
      let address_line_2 = optional (field "addressLine2" string) json in
      let city = field "city" string json in
      let state = field "state" string json in
      let zip = field "zip" string json in
      let country = field "country" string json in
      let rsvp_status = field "rsvpStatus" string json in
      let created_at = field "createdAt" string json in
      let updated_at = field "updatedAt" string json in
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
