@react.component
let make = () => {
  let {user} = AuthContext.useAuth()

  let authButton = switch user {
  | Some(_user) =>
    <a
      href="/dashboard"
      className="rounded-md bg-white px-3.5 py-2.5 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
      {React.string("Dashboard")}
    </a>
  | None =>
    <button
      onClick={_ => RescriptReactRouter.push("/login")}
      className="rounded-md bg-white px-3.5 py-2.5 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
      {React.string("Log in")}
    </button>
  }

  <div className="min-h-screen p-2">
    <header className="flex justify-between items-start">
      <div className="text-2xl font-bold"> {React.string("logo")} </div>
      authButton
    </header>
  </div>
}
