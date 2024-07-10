@react.component
let make = () => {
  let useUser = Clerk.useUser()

  let authButton = switch Js.Nullable.toOption(useUser["user"]) {
  | Some(_user) => <Clerk.SignOutButton> {React.string("Sign out")} </Clerk.SignOutButton>
  | None =>
    <a
      href="/login"
      className="rounded-md bg-white px-3.5 py-2.5 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
      {React.string("Log in")}
    </a>
  }

  <div className="min-h-screen p-2">
    <header className="flex justify-between items-start">
      <div className="text-2xl font-bold"> {React.string("logo")} </div>
      authButton
    </header>
  </div>
}
