@react.component
let make = () => {
  let useUser = Clerk.useUser()

  let home = switch Js.Nullable.toOption(useUser["user"]) {
  | Some(_user) => <Clerk.SignOutButton> {React.string("Sign out")} </Clerk.SignOutButton>
  | None => <Clerk.SignInButton> {React.string("Sign in")} </Clerk.SignInButton>
  }

  home
}
