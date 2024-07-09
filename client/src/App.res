let authenticated: (
  ClerkTypes.User.t => React.element,
  Js.Nullable.t<ClerkTypes.User.t>,
) => React.element = (getPage, user) =>
  switch Js.Nullable.toOption(user) {
  | Some(s) => getPage(s)
  | None =>
    RescriptReactRouter.push("/")
    React.null
  }

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let useUser = Clerk.useUser()

  switch useUser["isLoaded"] {
  | false => React.null
  | true =>
    <>
      {switch url.path {
      | list{"dashboard"} => authenticated(_ => <Dashboard />, useUser["user"])
      | list{"login"} => <LoginPage />
      | list{} => <HomePage />
      | _ => <FourOhFour />
      }}
    </>
  }
}
