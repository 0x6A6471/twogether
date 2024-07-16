open Fetch

type user = {
  id: string,
  name: string,
  email: string,
}

type formData = {
  email: string,
  password: string,
}

type contextValue = {
  isLoaded: bool,
  user: option<user>,
  setUser: (option<user> => option<user>) => unit,
  login: formData => promise<Js.Json.t>,
}

let context = React.createContext({
  isLoaded: false,
  user: None,
  setUser: _ => (),
  login: _ => Promise.resolve(Js.Json.null),
})

module AuthProvider = {
  let make = React.Context.provider(context)
}
module Provider = {
  @react.component
  let make = (~children) => {
    let (user, setUser) = React.useState(() => None)
    let (isLoaded, setIsLoaded) = React.useState(() => false)

    let login = async data => {
      setIsLoaded(_ => false)
      let response = await fetch(
        "http://localhost:8080/api/auth/login",
        {
          method: #POST,
          credentials: #"include",
          body: data->Js.Json.stringifyAny->Belt.Option.getExn->Body.string,
          headers: Headers.fromObject({
            "Content-type": "application/json",
          }),
        },
      )

      let data = await response->Response.json

      switch data->Js.Json.decodeObject {
      | Some(obj) =>
        switch (Js.Dict.get(obj, "id"), Js.Dict.get(obj, "name"), Js.Dict.get(obj, "email")) {
        | (Some(id), Some(name), Some(email)) =>
          let newUser: user = {
            id: id->Js.Json.decodeString->Belt.Option.getExn,
            name: name->Js.Json.decodeString->Belt.Option.getExn,
            email: email->Js.Json.decodeString->Belt.Option.getExn,
          }
          setUser(_ => Some(newUser))
          setIsLoaded(_ => true)
          RescriptReactRouter.push("/dashboard")
        | _ => () // Handle error case
        }
      | None => () // Handle error case
      }

      data
    }

    let validate = async () => {
      try {
        let response = await fetch(
          "http://localhost:8080/api/auth/validate",
          {
            credentials: #"include",
            headers: Headers.fromObject({
              "Content-Type": "application/json",
            }),
          },
        )

        let data = await response->Response.json

        switch data->Js.Json.decodeObject {
        | Some(obj) =>
          switch (Js.Dict.get(obj, "id"), Js.Dict.get(obj, "name"), Js.Dict.get(obj, "email")) {
          | (Some(id), Some(name), Some(email)) =>
            let newUser: user = {
              id: id->Js.Json.decodeString->Belt.Option.getExn,
              name: name->Js.Json.decodeString->Belt.Option.getExn,
              email: email->Js.Json.decodeString->Belt.Option.getExn,
            }
            setUser(_ => Some(newUser))
          | _ => () // Handle error case
          }
        | None => () // Handle error case
        }
      } catch {
      | _ => setUser(_ => None)
      }
      setIsLoaded(_ => true)
    }

    React.useEffect0(() => {
      validate()->ignore
      None
    })

    let value = {
      user,
      setUser,
      isLoaded,
      login,
    }

    <AuthProvider value> {children} </AuthProvider>
  }
}

let useAuth = () => React.useContext(context)
