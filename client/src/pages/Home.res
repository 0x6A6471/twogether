@react.component
let make = () => {
  let (isOpen, setIsOpen) = React.useState(_ => false)
  let {user} = AuthContext.useAuth()

  let authButton = switch user {
  | Some(_user) =>
    <Link
      href="/dashboard"
      className="rounded-md bg-white px-3.5 py-2.5 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-200 hover:bg-gray-50">
      {React.string("Dashboard")}
    </Link>
  | None =>
    <Link
      href="/login"
      className="rounded-md bg-white px-3.5 py-2.5 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-200 hover:bg-gray-50">
      {React.string("Log in")}
    </Link>
  }

  <div className="min-h-screen p-2">
    <header className="flex justify-between items-start">
      <div className="text-2xl font-bold"> {React.string("logo")} </div>
      authButton
    </header>
    <button onClick={_ => setIsOpen(_ => true)}> {React.string("Open dialog")} </button>
  </div>
}
