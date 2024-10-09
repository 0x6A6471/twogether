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

module Get : sig
  val use_guests : unit -> t array ReactQuery.query_state
end

module Post : sig
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

  val use_add_mutation
    :  ReactQuery.QueryClient.t
    -> (t, Js__Js_json.t, 'a, 'b) ReactQuery.mutation_state
end

module Put : sig
  val use_edit_mutation
    :  ReactQuery.QueryClient.t
    -> (t, Js__Js_json.t, 'a, 'b) ReactQuery.mutation_state
end

module Delete : sig
  val use_delete_mutation
    :  ReactQuery.QueryClient.t
    -> (t, Js__Js_json.t, 'a, 'b) ReactQuery.mutation_state
end
