@react.component
let make = (~guest: Models.Guest.t) => {
  let queryClient = ReactQuery.useQueryClient()

  let {mutate} = ReactQuery.useMutation({
    mutationFn: Models.Guest.deleteGuest,
    onSuccess: (data, _, _) => {
      switch Js.Json.decodeObject(data) {
      | Some(obj) =>
        switch Js.Dict.get(obj, "error") {
        | Some(_error) => RescriptReactRouter.push("/login")
        | None => queryClient->ReactQuery.QueryClient.invalidateQueries({queryKey: ["guests"]})
        }
      | None => ()
      }
    },
  })

  <Dialog.Root>
    <Dialog.Trigger>
      <Radix.Tooltip.Provider>
        <Radix.Tooltip.Root delayDuration={200}>
          <Radix.Tooltip.Trigger asChild={true}>
            <span
              className="hidden rounded-md bg-white p-1.5 text-sm hover:bg-rose-50 hover:text-rose-700 sm:block">
              <Icon name="trash" />
            </span>
          </Radix.Tooltip.Trigger>
          <Radix.Tooltip.Portal>
            <Radix.Tooltip.Content
              className="select-none rounded bg-black text-white p-2 leading-none shadow text-xs"
              sideOffset={4}>
              {React.string(`Delete ${guest.first_name} ${guest.last_name}`)}
            </Radix.Tooltip.Content>
          </Radix.Tooltip.Portal>
        </Radix.Tooltip.Root>
      </Radix.Tooltip.Provider>
    </Dialog.Trigger>
    <Dialog.Portal>
      <Dialog.Overlay className="bg-gray-950/70 fixed inset-0" />
      <Dialog.Content
        className="fixed top-1/2 left-1/2 w-5/6 sm:w-4/5 md:max-w-screen-sm -translate-x-1/2 -translate-y-1/2 rounded-2xl bg-white p-8 shadow-sm focus:outline-none overflow-y-scroll">
        <Dialog.Title className="text-2xl font-semibold text-center text-gray-950">
          {React.string(`Delete ${guest.first_name} ${guest.last_name}`)}
        </Dialog.Title>
        <Dialog.Description className="mt-4 mb-8 text-center">
          {React.string(
            "Are you sure you want to delete this guest? This action cannot be undone.",
          )}
        </Dialog.Description>
        <div className="mt-8 flex space-x-4">
          <Dialog.Close asChild=true>
            <button
              className="w-full rounded-xl bg-gray-100 px-3 py-2 text-sm font-medium text-gray-950 shadow-sm hover:bg-gray-200">
              <span> {React.string("Cancel")} </span>
            </button>
          </Dialog.Close>
          <button
            className="w-full rounded-xl bg-rose-600 text-rose-50 px-3 py-2 text-sm font-medium shadow-sm hover:bg-rose-700"
            onClick={_ => mutate(guest)}>
            <span> {React.string("Delete")} </span>
          </button>
        </div>
        <Dialog.Close asChild=true>
          <button
            className="p-2 hover:bg-gray-50 absolute top-2 right-2 inline-flex items-center justify-center rounded-lg focus:outline-none">
            <Ui.Icon name="x" />
          </button>
        </Dialog.Close>
      </Dialog.Content>
    </Dialog.Portal>
  </Dialog.Root>
}
