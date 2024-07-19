type t = {
  name: string,
  href: string,
  icon: string,
}

let navigation = [
  {name: "Home", href: "/dashboard", icon: "home-filled"},
  {name: "Guests", href: "/dashboard/guests", icon: "users-filled"},
]

@react.component
let make = (~children: React.element) => {
  let (sidebarOpen, setSidebarOpen) = React.useState(() => false)

  let url = RescriptReactRouter.useUrl()
  let path = "/" ++ url.path->Belt.List.toArray->Js.Array2.joinWith("/")

  <div>
    <HeadlessUi.Dialog
      open_={sidebarOpen} onClose={setSidebarOpen} className="relative z-50 lg:hidden">
      <HeadlessUi.DialogBackdrop
        transition={true}
        className="fixed inset-0 bg-gray-900/80 transition-opacity duration-300 ease-linear data-[closed]:opacity-0"
      />
      <div className="fixed inset-0 flex">
        <HeadlessUi.DialogPanel
          transition={true}
          className="relative mr-16 flex w-full max-w-xs flex-1 transform transition duration-300 ease-in-out data-[closed]:-translate-x-full">
          <HeadlessUi.TransitionChild>
            <div
              className="absolute left-full top-0 flex w-16 justify-center pt-5 duration-300 ease-in-out data-[closed]:opacity-0">
              <button onClick={_ => setSidebarOpen(_ => false)} className="-m-2.5 p-2.5">
                <span className="sr-only"> {React.string("Close sidebar")} </span>
                <Icon name="x" size="24" className="text-white" />
              </button>
            </div>
          </HeadlessUi.TransitionChild>
          //Sidebar component, swap this element with another sidebar if you like
          <div className="flex grow flex-col gap-y-5 overflow-y-auto bg-white px-6 pb-4">
            <div className="flex h-16 shrink-0 items-center">
              <img
                alt="Your Company"
                src="https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=600"
                className="h-8 w-auto"
              />
            </div>
            <nav className="flex flex-1 flex-col">
              <ul role="list" className="flex flex-1 flex-col gap-y-7">
                <li>
                  <ul role="list" className="-mx-2 space-y-1">
                    {Array.map(navigation, item => {
                      <li key={item.name}>
                        <Link
                          href={item.href}
                          className={`${" group flex gap-x-3 rounded-md p-2 text-sm font-medium leading-6 items-center"} ${path ===
                              item.href
                              ? "bg-gray-200 text-gray-900"
                              : "hover:bg-gray-200 hover:text-gray-900"}`}>
                          <Icon name={item.icon} />
                          {React.string(item.name)}
                        </Link>
                      </li>
                    })->React.array}
                  </ul>
                </li>
                <li className="mt-auto">
                  <a
                    href="#"
                    className="group -mx-2 gap-x-3 rounded-md p-2 text-sm font-semibold leading-6 text-gray-700 hover:bg-gray-50 hover:text-indigo-600 flex items-center">
                    <Icon name="gear" />
                    {React.string("Settings")}
                  </a>
                </li>
              </ul>
            </nav>
          </div>
        </HeadlessUi.DialogPanel>
      </div>
    </HeadlessUi.Dialog>
    // Static sidebar for desktop
    <div className="hidden lg:fixed lg:inset-y-0 lg:z-50 lg:flex lg:w-72 lg:flex-col">
      // Sidebar component, swap this element with another sidebar if you like
      <div
        className="flex grow flex-col gap-y-5 overflow-y-auto border-r border-gray-100 bg-white rounded px-6 pb-4">
        <div className="flex h-16 shrink-0 items-center">
          <img
            alt="Your Company"
            src="https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=600"
            className="h-8 w-auto"
          />
        </div>
        <nav className="flex flex-1 flex-col">
          <ul role="list" className="flex flex-1 flex-col gap-y-7">
            <li>
              <ul role="list" className="-mx-2 space-y-1">
                {Array.map(navigation, item => {
                  <li key={item.name}>
                    <Link
                      href={item.href}
                      className={`${"group flex gap-x-3 rounded-md p-2 text-sm font-medium leading-6 items-center"} ${path ===
                          item.href
                          ? "bg-gray-100 text-gray-900"
                          : "hover:bg-gray-100 hover:text-gray-900"}`}>
                      <Icon name={item.icon} />
                      {React.string(item.name)}
                    </Link>
                  </li>
                })->React.array}
              </ul>
            </li>
            <li className="mt-auto">
              // <a
              //   href="#"
              //   className="group -mx-2 gap-x-3 rounded-md p-2 text-sm font-semibold leading-6 text-gray-700 hover:bg-gray-50 hover:text-indigo-600 flex items-center">
              //   <Icon name="gear" />
              //   {React.string("Settings")}
              // </a>
              <UserDropdown />
            </li>
          </ul>
        </nav>
      </div>
    </div>
    <div className="lg:pl-72 bg-gray-50">
      <button
        onClick={_ => setSidebarOpen(_ => true)}
        className="ml-3 mt-1 p-1 text-gray-500 lg:hidden hover:bg-gray-100 rounded">
        <span className="sr-only"> {React.string("Open sidebar")} </span>
        <Icon name="grid" />
      </button>
      <main className="p-4 bg-gray-50 min-h-screen"> children </main>
    </div>
  </div>
}
