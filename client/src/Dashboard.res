@react.component
let make = () => {
  let useUser = Clerk.useUser()

  let name = switch Js.Nullable.toOption(useUser["user"]) {
  | Some(user) =>
    switch user.fullName {
    | Some(name) => <h1> {React.string("Hello, " ++ name)} </h1>
    | None => React.null
    }
  | None => React.null
  }

  <header>
    {name}
    <Clerk.SignedOut>
      <Clerk.SignInButton> {React.string("Sign in")} </Clerk.SignInButton>
    </Clerk.SignedOut>
    <Clerk.SignedIn>
      <Clerk.SignOutButton> {React.string("Sign out")} </Clerk.SignOutButton>
    </Clerk.SignedIn>
  </header>
}
