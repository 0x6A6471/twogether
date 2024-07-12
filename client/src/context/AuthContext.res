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
  user: option<user>,
  setUser: (option<user> => option<user>) => unit,
  login: formData => promise<Js.Json.t>,
}

let context = React.createContext({
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

    let login = async data => {
      let response = await fetch(
        "http://localhost:8080/api/auth/login",
        {
          method: #POST,
          body: data->Js.Json.stringifyAny->Belt.Option.getExn->Body.string,
          headers: Headers.fromObject({
            "Content-type": "application/json",
          }),
        },
      )

      await response->Response.json
    }

    let value = {
      user,
      setUser,
      login,
    }

    <AuthProvider value> {children} </AuthProvider>
  }
}

let useAuth = () => React.useContext(context)
