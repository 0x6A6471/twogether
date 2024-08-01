let authenticated: (
  AuthContext.user => React.element,
  bool,
  option<AuthContext.user>,
) => React.element = (getPage, isLoading, user) =>
  switch isLoading {
  | true => React.null
  | false =>
    switch user {
    | Some(s) => <Nav> {getPage(s)} </Nav>
    | None =>
      RescriptReactRouter.push("/login")
      React.null
    }
  }

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  let {isLoading, user} = AuthContext.useAuth()

  switch url.path {
  | list{"dashboard"} => authenticated(_ => <Dashboard />, isLoading, user)
  | list{"dashboard", "guests"} => authenticated(_ => <Guests />, isLoading, user)
  | list{"login"} => <Login />
  | list{"signup"} => <Signup />
  | list{} => <Home />
  | _ => <FourOhFour />
  }
}
