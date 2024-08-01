open Fetch

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
}
module Codecs = {
  let rsvpStatusCodec: Jzon.codec<rsvpStatus> = Jzon.custom(
    status =>
      switch status {
      | #not_invited => Js.Json.string("not_invited")
      | #invited => Js.Json.string("invited")
      | #accepted => Js.Json.string("accepted")
      | #declined => Js.Json.string("declined")
      },
    json =>
      switch Js.Json.decodeString(json) {
      | Some("not_invited") => Ok(#not_invited)
      | Some("invited") => Ok(#invited)
      | Some("accepted") => Ok(#accepted)
      | Some("declined") => Ok(#declined)
      | _ => Error(#UnexpectedJsonValue([Field("rsvp_status")], "UnexpectedJsonValue"))
      },
  )

  let guest = Jzon.object11(
    // Function to encode original object to linear tuple
    ({
      id,
      first_name,
      last_name,
      email,
      address_line_1,
      address_line_2,
      city,
      state,
      zip,
      country,
      rsvp_status,
    }) => (
      id,
      first_name,
      last_name,
      email,
      address_line_1,
      address_line_2,
      city,
      state,
      zip,
      country,
      rsvp_status,
    ),
    // Function to decode linear tuple back to object
    ((
      id,
      first_name,
      last_name,
      email,
      address_line_1,
      address_line_2,
      city,
      state,
      zip,
      country,
      rsvp_status,
    )) =>
      {
        id,
        first_name,
        last_name,
        email,
        address_line_1,
        address_line_2,
        city,
        state,
        zip,
        country,
        rsvp_status,
      }->Ok,
    // Field names and codecs for the tuple elements
    Jzon.field("id", Jzon.string),
    Jzon.field("first_name", Jzon.string),
    Jzon.field("last_name", Jzon.string),
    Jzon.field("email", Jzon.string),
    Jzon.field("address_line_1", Jzon.string),
    Jzon.field("address_line_2", Jzon.nullable(Jzon.string)),
    Jzon.field("city", Jzon.string),
    Jzon.field("state", Jzon.string),
    Jzon.field("zip", Jzon.string),
    Jzon.field("country", Jzon.string),
    Jzon.field("rsvp_status", rsvpStatusCodec),
  )
}

let decodeGuest = (json: Js.Json.t) => {
  json->Jzon.decodeWith(Jzon.array(Codecs.guest))
}

let fetchGuests = _ => {
  let toResult = json =>
    switch decodeGuest(json) {
    | Ok(guests) => Ok(guests)
    | Error(err) =>
      switch err {
      | #MissingField(_location, string) => raise(Failure("Missing field: " ++ string))
      | #SyntaxError(string) => raise(Failure("Syntax error: " ++ string))
      | #UnexpectedJsonType(_location, string, _json) =>
        raise(Failure("Unexpected json type: " ++ string))
      | #UnexpectedJsonValue(_location, string) =>
        raise(Failure("Unexpected json value: " ++ string))
      }
    }

  Fetch.fetch(
    `${Env.viteDatabaseApiUrl}/api/guests`,
    {
      credentials: #"include",
    },
  )
  ->Promise.then(Response.json)
  ->Promise.thenResolve(toResult)
}
