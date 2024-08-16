type rsvpStatus = [#not_invited | #invited | #accepted | #declined]

type t = {
  id: string,
  first_name: string,
  last_name: string,
  email: string,
  address_line_1: string,
  address_line_2: option<string>,
  city: string,
  state: string,
  zip: string,
  country: string,
  rsvp_status: rsvpStatus,
  inserted_at: string,
}

module Codecs: {
  let addressLine2Codec: Jzon.codec<option<string>>
  let rsvpStatusCodec: Jzon.codec<rsvpStatus>
  let guest: Jzon.codec<t>
}

let decodeGuest: Js.Json.t => result<array<t>, Jzon.DecodingError.t>

let fetchGuests: 'a => RescriptCore.Promise.t<result<array<t>, 'b>>
