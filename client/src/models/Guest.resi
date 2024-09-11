type rsvpStatus = [#not_invited | #invited | #accepted | #declined]

type t = {
  id: string,
  userId: string,
  firstName: string,
  lastName: string,
  email: string,
  addressLine1: string,
  addressLine2: option<string>,
  city: string,
  state: string,
  zip: string,
  country: string,
  rsvpStatus: rsvpStatus,
  createdAt: string,
  updatedAt: string,
}

module Codecs: {
  let addressLine2Codec: Jzon.codec<option<string>>
  let rsvpStatusCodec: Jzon.codec<rsvpStatus>
  let guest: Jzon.codec<t>
}

let encodeGuest: t => string

let decodeGuest: Js.Json.t => result<t, Jzon.DecodingError.t>
let decodeGuests: Js.Json.t => result<array<t>, Jzon.DecodingError.t>

let fetchGuests: 'a => RescriptCore.Promise.t<result<array<t>, 'b>>
let editGuest: t => RescriptCore.Promise.t<Js.Json.t>
let deleteGuest: t => RescriptCore.Promise.t<Js.Json.t>
