@react.component
let make = () => {
  let (isOpen, setIsOpen) = React.useState(_ => false)
  let {logout, user} = AuthContext.useAuth()

  let name = switch user {
  | Some(user) => user.name
  | None => "Guest"
  }

  let handleLogout = () => {
    logout()->ignore
  }

  <Radix.DropdownMenu.Root open_={isOpen} onOpenChange={setIsOpen}>
    <Radix.DropdownMenu.Trigger asChild={true}>
      <div className="-mx-2 -mb-2 mt-auto">
        <button
          className="p-2 rounded-xl w-full flex justify-between items-center shadow outline-none text-sm border border-gray-50">
          <div className="inline-flex space-x-3 items-center">
            <Ui.Icon name="user" variant={#filled} />
            <span> {React.string(name)} </span>
          </div>
          <Ui.Icon
            name="chevron-up"
            variant={#filled}
            size="20"
            className={`transform transition duration-150 ${isOpen ? "rotate-180" : ""}`}
          />
        </button>
      </div>
    </Radix.DropdownMenu.Trigger>
    <Radix.DropdownMenu.Portal>
      <Radix.DropdownMenu.Content
        className="min-w-[271px] bg-white z-50 rounded-lg p-[5px] shadow-md will-change-[opacity,transform] data-[side=top]:animate-slideDownAndFade data-[side=right]:animate-slideLeftAndFade data-[side=bottom]:animate-slideUpAndFade data-[side=left]:animate-slideRightAndFade"
        sideOffset={5}>
        <Radix.DropdownMenu.Item
          onSelect={_ => handleLogout()}
          className="group text-sm leading-none rounded flex items-center p-2 space-x-3 select-none outline-none text-gray-600 hover:text-gray-950 hover:bg-gray-50">
          <Ui.Icon name="log-out" />
          <span> {React.string("Log out")} </span>
        </Radix.DropdownMenu.Item>
        <Radix.DropdownMenu.Item
          className="group text-sm leading-none rounded flex items-center p-2 space-x-3 select-none outline-none text-gray-600 hover:text-gray-950 hover:bg-gray-50">
          <Ui.Icon name="question" />
          <span> {React.string("Support")} </span>
        </Radix.DropdownMenu.Item>
      </Radix.DropdownMenu.Content>
    </Radix.DropdownMenu.Portal>
  </Radix.DropdownMenu.Root>
}
