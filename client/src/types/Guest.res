type rsvpStatus =
  | @as("not_invited") NotInvited
  | @as("invited") Invited
  | @as("accepted") Accepted
  | @as("declined") Declined

type t = {
  id: string,
  first_name: string,
  last_name: string,
  email: string,
  address_line_1: string,
  address_line_2: nullable<string>,
  city: string,
  state: string,
  zip: string,
  country: string,
  rsvp_status: rsvpStatus,
}
