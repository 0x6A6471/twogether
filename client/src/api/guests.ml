open Utils
open ReactQuery

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

module Get = struct
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

  module Decode = struct
    let guest json =
      Json.Decode.(
        json
        |> fun json ->
        let id = field "id" string json in
        let user_id = field "user_id" string json in
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

  let get_user_guests _ = Fetcher.get "/api/guests" ~decoder:Decode.guests

  let use_guests () =
    useQuery (make_query ~queryKey:[| "guests" |] ~queryFn:get_user_guests ())
  ;;
end

module Post = struct
  type t =
    { first_name : string
    ; last_name : string
    ; email : string
    ; address_line_1 : string
    ; address_line_2 : string option
    ; city : string
    ; state : string
    ; zip : string
    ; country : string
    ; rsvp_status : rsvp_status
    }

  let add_guest form_data =
    let payload = Js.Dict.empty () in
    Js.Dict.set payload "first_name" (Js.Json.string form_data.first_name);
    Js.Dict.set payload "last_name" (Js.Json.string form_data.last_name);
    Js.Dict.set payload "email" (Js.Json.string form_data.email);
    Js.Dict.set
      payload
      "address_line_1"
      (Js.Json.string form_data.address_line_1);
    Js.Dict.set
      payload
      "address_line_2"
      (Js.Json.string (Belt.Option.getWithDefault form_data.address_line_2 ""));
    Js.Dict.set payload "city" (Js.Json.string form_data.city);
    Js.Dict.set payload "state" (Js.Json.string form_data.state);
    Js.Dict.set payload "zip" (Js.Json.string form_data.zip);
    Js.Dict.set payload "country" (Js.Json.string form_data.country);
    Js.Dict.set
      payload
      "rsvp_status"
      (Js.Json.string
         (match form_data.rsvp_status with
          | `not_invited -> "not_invited"
          | `invited -> "invited"
          | `accepted -> "accepted"
          | `declined -> "declined"));
    Fetcher.req_with_body "/api/guests" ~method_:Post ~payload
  ;;

  let use_guest_mutation queryClient =
    useMutation
      { mutationFn = add_guest
      ; retry = None
      ; retryDelay = None
      ; onMutate = None
      ; onError = Some (fun _ _ _ -> Js.log "Error")
      ; onSuccess =
          Some
            (fun _ _ _ ->
              QueryClient.invalidateQueries
                queryClient
                { queryKey = [| "guests" |]; exact = Some true })
      ; onSettled = None
      }
  ;;
end

module Delete = struct
  let delete_guest guest =
    let payload = Js.Dict.empty () in
    Js.Dict.set payload "user_id" (Js.Json.string guest.user_id);
    Fetcher.req_with_body ("/api/guests/" ^ guest.id) ~method_:Delete ~payload
  ;;

  let use_delete_mutation queryClient =
    useMutation
      { mutationFn = delete_guest
      ; retry = None
      ; retryDelay = None
      ; onMutate = None
      ; onError = Some (fun _ _ _ -> Js.log "Error")
      ; onSuccess =
          Some
            (fun _ _ _ ->
              QueryClient.invalidateQueries
                queryClient
                { queryKey = [| "guests" |]; exact = Some true })
      ; onSettled = None
      }
  ;;
end
