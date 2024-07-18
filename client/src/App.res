let authenticated: (
  AuthContext.user => React.element,
  option<AuthContext.user>,
) => React.element = (getPage, user) =>
  switch user {
  | Some(s) => <Nav> {getPage(s)} </Nav>
  | None =>
    RescriptReactRouter.push("/")
    React.null
  }

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  let {isLoaded, user} = AuthContext.useAuth()

  switch isLoaded {
  | false => React.null
  | true =>
    <>
      {switch url.path {
      | list{"dashboard"} => authenticated(_ => <Dashboard />, user)
      | list{"dashboard", "guests"} => authenticated(_ => <Guests />, user)
      | list{"login"} => <Login />
      | list{"signup"} => <Signup />
      | list{} => <Home />
      | _ => <FourOhFour />
      }}
    </>
  }
}
