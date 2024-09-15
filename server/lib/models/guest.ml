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
[@@deriving yojson]

let make
  ~id
  ~user_id
  ~first_name
  ~last_name
  ~email
  ~address_line_1
  ~address_line_2
  ~city
  ~state
  ~zip
  ~country
  ~rsvp_status
  ~created_at
  ~updated_at
  =
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
  }
;;
