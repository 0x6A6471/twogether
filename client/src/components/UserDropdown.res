@react.component
let make = () => {
  let {user} = AuthContext.useAuth()
  let name = switch user {
  | Some(user) => user.name
  | None => "Guest"
  }

  <Radix.DropdownMenu.Root>
    <Radix.DropdownMenu.Trigger asChild={true}>
      <div className="-mx-2">
        <button
          className="p-2 rounded-md w-full inline-flex items-center bg-white shadow outline-none space-x-3 text-sm">
          <Icon name="user" variant={#filled} />
          <span> {React.string(name)} </span>
        </button>
      </div>
    </Radix.DropdownMenu.Trigger>
    <Radix.DropdownMenu.Portal>
      <Radix.DropdownMenu.Content
        className="min-w-[255px] bg-white z-50 rounded-md p-[5px] shadow-[0px_10px_38px_-10px_rgba(22,_23,_24,_0.35),_0px_10px_20px_-15px_rgba(22,_23,_24,_0.2)] will-change-[opacity,transform] data-[side=top]:animate-slideDownAndFade data-[side=right]:animate-slideLeftAndFade data-[side=bottom]:animate-slideUpAndFade data-[side=left]:animate-slideRightAndFade"
        sideOffset={5}>
        <Radix.DropdownMenu.Item
          className="group text-sm leading-none rounded-sm flex items-center p-2 space-x-3 select-none outline-none hover:bg-gray-50">
          <Icon name="log-out" />
          <span> {React.string("Log out")} </span>
        </Radix.DropdownMenu.Item>
        <Radix.DropdownMenu.Item
          className="group text-sm leading-none rounded-sm flex items-center p-2 space-x-3 select-none outline-none hover:bg-gray-50">
          <Icon name="log-out" />
          <span> {React.string("another item")} </span>
        </Radix.DropdownMenu.Item>
      </Radix.DropdownMenu.Content>
    </Radix.DropdownMenu.Portal>
  </Radix.DropdownMenu.Root>
}
