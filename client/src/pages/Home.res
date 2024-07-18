@react.component
let make = () => {
  let (isOpen, setIsOpen) = React.useState(_ => false)
  let {user} = AuthContext.useAuth()

  let authButton = switch user {
  | Some(_user) =>
    <Link
      href="/dashboard"
      className="rounded-md bg-white px-3.5 py-2.5 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
      {React.string("Dashboard")}
    </Link>
  | None =>
    <Link
      href="/login"
      className="rounded-md bg-white px-3.5 py-2.5 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50">
      {React.string("Log in")}
    </Link>
  }

  <div className="min-h-screen p-2">
    <header className="flex justify-between items-start">
      <div className="text-2xl font-bold"> {React.string("logo")} </div>
      authButton
    </header>
    <button onClick={_ => setIsOpen(_ => true)}> {React.string("Open dialog")} </button>
    <HeadlessUi.Dialog
      open_={isOpen} onClose={_ => setIsOpen(_ => false)} className="relative z-50">
      <div className="fixed inset-0 flex w-screen items-center justify-center p-4 bg-black/80">
        <HeadlessUi.DialogPanel className="max-w-lg space-y-4 border bg-white p-12">
          <HeadlessUi.DialogTitle className="font-bold">
            {React.string("Deactivate account")}
          </HeadlessUi.DialogTitle>
          <HeadlessUi.Description>
            {React.string("This will permanently deactivate your account")}
          </HeadlessUi.Description>
          <p>
            {React.string(
              "Are you sure you want to deactivate your account? All of your data will be permanently removed.",
            )}
          </p>
          <div className="flex gap-4">
            <button onClick={_ => setIsOpen(_ => false)}> {React.string("Cancel")} </button>
            <button onClick={_ => setIsOpen(_ => false)}> {React.string("Deactivate")} </button>
          </div>
        </HeadlessUi.DialogPanel>
      </div>
    </HeadlessUi.Dialog>
  </div>
}
