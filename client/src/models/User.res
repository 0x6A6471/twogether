open Fetch

type t = {
  name: string,
  email: string,
  password: string,
  password2: string,
}

module Codecs = {
  let user = Jzon.object4(
    // function to encode original object to linear tuple
    ({name, email, password, password2}) => (name, email, password, password2),
    // function to decode linear tuple to original object
    ((name, email, password, password2)) =>
      {
        name,
        email,
        password,
        password2,
      }->Ok,
    // field names and codecs for tuple elements
    Jzon.field("name", Jzon.string),
    Jzon.field("email", Jzon.string),
    Jzon.field("password", Jzon.string),
    Jzon.field("password2", Jzon.string),
  )
}

let encodeUser = (user: t) => {
  Js.Json.stringify(user->Jzon.encodeWith(Codecs.user))
}

let decodeUser = (json: Js.Json.t) => {
  json->Jzon.decodeWith(Codecs.user)
}

let createUser = (user: t) => {
  Console.log2("USER IN MODELS", user)
  Fetch.fetch(
    `${Env.viteDatabaseApiUrl}/api/auth/signup`,
    {
      method: #POST,
      body: encodeUser(user)->Fetch.Body.string,
      headers: Fetch.Headers.fromObject({
        "Content-Type": "application/json",
      }),
      credentials: #"include",
    },
  )->Promise.then(Response.json)
}
