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
  ; rsvp_status : string
  ; created_at : string
  ; updated_at : string
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
