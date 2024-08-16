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
  isLoading: bool,
  user: option<user>,
  setUser: (option<user> => option<user>) => unit,
  login: formData => promise<Js.Json.t>,
  logout: unit => promise<unit>,
}

let context = React.createContext({
  isLoading: false,
  user: None,
  setUser: _ => (),
  login: _ => Promise.resolve(Js.Json.null),
  logout: _ => Promise.resolve(),
})

module AuthProvider = {
  let make = React.Context.provider(context)
}

module Provider = {
  @react.component
  let make = (~children) => {
    let (user, setUser) = React.useState(() => None)
    let (isLoading, setIsLoading) = React.useState(() => true)

    let login = async data => {
      setIsLoading(_ => true)
      let response = await fetch(
        `${Env.viteDatabaseApiUrl}/api/auth/login`,
        {
          method: #POST,
          credentials: #"include",
          body: data->Js.Json.stringifyAny->RescriptCore.Option.getExn->Body.string,
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
            id: id->Js.Json.decodeString->RescriptCore.Option.getExn,
            name: name->Js.Json.decodeString->RescriptCore.Option.getExn,
            email: email->Js.Json.decodeString->RescriptCore.Option.getExn,
          }
          setUser(_ => Some(newUser))
          setIsLoading(_ => false)
          RescriptReactRouter.push("/dashboard")
        // TODO
        | _ => () // Handle error case
        }
      // TODO
      | None => () // Handle error case
      }

      setIsLoading(_ => false)

      data
    }

    let logout = async () => {
      setIsLoading(_ => true)
      let _ = await fetch(
        `${Env.viteDatabaseApiUrl}/api/auth/logout`,
        {
          method: #POST,
          credentials: #"include",
        },
      )

      setUser(_ => None)
      setIsLoading(_ => false)
      RescriptReactRouter.push("/")
    }

    let validate = async () => {
      try {
        let response = await fetch(
          `${Env.viteDatabaseApiUrl}/api/auth/validate`,
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
              id: id->Js.Json.decodeString->RescriptCore.Option.getExn,
              name: name->Js.Json.decodeString->RescriptCore.Option.getExn,
              email: email->Js.Json.decodeString->RescriptCore.Option.getExn,
            }
            setUser(_ => Some(newUser))
          // TODO
          | _ => () // Handle error case
          }
        // TODO
        | None => () // Handle error case
        }
      } catch {
      | _ => setUser(_ => None)
      }
      setIsLoading(_ => false)
    }

    React.useEffect0(() => {
      validate()->ignore
      None
    })

    let value = {
      user,
      setUser,
      isLoading,
      login,
      logout,
    }

    <AuthProvider value> {children} </AuthProvider>
  }
}

let useAuth = () => React.useContext(context)
