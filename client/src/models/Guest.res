open Fetch

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

module Codecs = {
  let addressLine2Codec: Jzon.codec<option<string>> = Jzon.custom(
    line2 =>
      switch line2 {
      | Some(line2) => Js.Json.string(line2)
      | None => Js.Json.null
      },
    json =>
      switch Js.Json.decodeString(json) {
      | Some(line2) if line2 !== "" => Ok(Some(line2))
      | _ => Ok(None)
      },
  )

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

  let guest = Jzon.object14(
    // Function to encode original object to linear tuple
    ({
      id,
      userId,
      firstName,
      lastName,
      email,
      addressLine1,
      addressLine2,
      city,
      state,
      zip,
      country,
      rsvpStatus,
      createdAt,
      updatedAt,
    }) => (
      id,
      userId,
      firstName,
      lastName,
      email,
      addressLine1,
      addressLine2,
      city,
      state,
      zip,
      country,
      rsvpStatus,
      createdAt,
      updatedAt,
    ),
    // Function to decode linear tuple back to object
    ((
      id,
      userId,
      firstName,
      lastName,
      email,
      addressLine1,
      addressLine2,
      city,
      state,
      zip,
      country,
      rsvpStatus,
      createdAt,
      updatedAt,
    )) =>
      {
        id,
        userId,
        firstName,
        lastName,
        email,
        addressLine1,
        addressLine2,
        city,
        state,
        zip,
        country,
        rsvpStatus,
        createdAt,
        updatedAt,
      }->Ok,
    // Field names and codecs for the tuple elements
    Jzon.field("id", Jzon.string),
    Jzon.field("userId", Jzon.string),
    Jzon.field("firstName", Jzon.string),
    Jzon.field("lastName", Jzon.string),
    Jzon.field("email", Jzon.string),
    Jzon.field("addressLine1", Jzon.string),
    Jzon.field("addressLine2", addressLine2Codec),
    Jzon.field("city", Jzon.string),
    Jzon.field("state", Jzon.string),
    Jzon.field("zip", Jzon.string),
    Jzon.field("country", Jzon.string),
    Jzon.field("rsvpStatus", rsvpStatusCodec),
    Jzon.field("createdAt", Jzon.string),
    Jzon.field("updatedAt", Jzon.string),
  )
}

let encodeGuest = (guest: t) => {
  let json = Codecs.guest->Jzon.encode(guest)
  Js.Json.stringify(json)
}

let decodeGuest = (json: Js.Json.t) => {
  json->Jzon.decodeWith(Codecs.guest)
}

let decodeGuests = (json: Js.Json.t) => {
  json->Jzon.decodeWith(Jzon.array(Codecs.guest))
}

let fetchGuests = _ => {
  let toResult = json =>
    switch decodeGuests(json) {
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

let editGuest = (guest: t) => {
  Fetch.fetch(
    `${Env.viteDatabaseApiUrl}/api/guests/${guest.id}`,
    {
      method: #PUT,
      body: Fetch.Body.string(encodeGuest(guest)),
      headers: Fetch.Headers.fromObject({
        "Content-Type": "application/json",
      }),
      credentials: #"include",
    },
  )->Promise.then(Response.json)
}

let deleteGuest = (guest: t) => {
  Fetch.fetch(
    `${Env.viteDatabaseApiUrl}/api/guests/${guest.id}`,
    {
      method: #DELETE,
      body: Fetch.Body.string(guest.userId),
      headers: Fetch.Headers.fromObject({
        "Content-Type": "application/json",
      }),
      credentials: #"include",
    },
  )->Promise.then(Response.json)
}
