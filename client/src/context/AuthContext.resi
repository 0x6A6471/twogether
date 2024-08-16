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

let context: React.Context.t<contextValue>

module AuthProvider: {
  let make: React.component<React.Context.props<contextValue>>
}

module Provider: {
  @react.component
  let make: (~children: React.element) => React.element
}

let useAuth: unit => contextValue
