@react.component
let make = (~guest: Models.Guest.t) => {
  let queryClient = ReactQuery.useQueryClient()
  let (formData, setFormData) = React.useState(_ => guest)

  let {mutate} = ReactQuery.useMutation({
    mutationFn: Models.Guest.editGuest,
    onSuccess: (_, _, _) =>
      queryClient->ReactQuery.QueryClient.invalidateQueries({queryKey: ["guests"]}),
  })

  let onSubmit = (e: JsxEvent.Form.t) => {
    e->ReactEvent.Form.preventDefault
    mutate(formData)->ignore
  }

  <Dialog.Root>
    <Dialog.Trigger>
      <Ui.ButtonTooltip label={`Edit ${guest.firstName} ${guest.lastName}`} icon="edit" />
    </Dialog.Trigger>
    <Dialog.Portal>
      <Dialog.Overlay className="bg-gray-950/70 fixed inset-0" />
      <Dialog.Content
        className="fixed top-1/2 left-1/2 w-5/6 sm:w-4/5 md:max-w-screen-sm -translate-x-1/2 -translate-y-1/2 rounded-2xl bg-white p-8 shadow-sm focus:outline-none overflow-y-scroll">
        <Dialog.Title className="text-2xl font-semibold text-center text-gray-950">
          {React.string("Add Guest")}
        </Dialog.Title>
        <Dialog.Description className="mt-4 mb-8 text-center">
          {React.string("Enter the guest's information below.")}
        </Dialog.Description>
        <form onSubmit>
          <div className="grid grid-cols-1 gap-x-4 gap-y-6 sm:grid-cols-6">
            <div className="sm:col-span-3">
              <label
                htmlFor="first-name" className="block text-sm font-medium leading-6 text-gray-950">
                {React.string("First name")}
              </label>
              <div>
                <input
                  id="first-name"
                  type_="text"
                  name="first-name"
                  autoFocus=true
                  required=true
                  className="block w-full rounded-md border-0 py-1.5 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-inset focus:ring-gray-400 sm:text-sm sm:leading-6"
                  defaultValue=guest.firstName
                  onChange={(ev: JsxEvent.Form.t) => {
                    let target = JsxEvent.Form.target(ev)
                    let firstName = target["value"]
                    setFormData(_prev => {...formData, firstName})
                  }}
                />
              </div>
            </div>
            <div className="sm:col-span-3">
              <label
                htmlFor="last-name" className="block text-sm font-medium leading-6 text-gray-950">
                {React.string("Last name")}
              </label>
              <div>
                <input
                  id="last-name"
                  type_="text"
                  name="last-name"
                  required=true
                  className="block w-full rounded-md border-0 py-1.5 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-inset focus:ring-gray-400 sm:text-sm sm:leading-6"
                  defaultValue=guest.lastName
                  onChange={(ev: JsxEvent.Form.t) => {
                    let target = JsxEvent.Form.target(ev)
                    let lastName = target["value"]
                    setFormData(_prev => {...formData, lastName})
                  }}
                />
              </div>
            </div>
            <div className="sm:col-span-4">
              <label htmlFor="email" className="block text-sm font-medium leading-6 text-gray-950">
                {React.string("Email address")}
              </label>
              <input
                id="email"
                type_="email"
                name="email"
                required=true
                className="block w-full rounded-md border-0 py-1.5 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-inset focus:ring-gray-400 sm:text-sm sm:leading-6"
                defaultValue=guest.email
                onChange={(ev: JsxEvent.Form.t) => {
                  let target = JsxEvent.Form.target(ev)
                  let email = target["value"]
                  setFormData(_prev => {...formData, email})
                }}
              />
            </div>
            <div className="sm:col-span-4">
              <label
                htmlFor="street-address"
                className="block text-sm font-medium leading-6 text-gray-950">
                {React.string("Street address")}
              </label>
              <input
                id="street-address"
                type_="text"
                name="street-address"
                required=true
                defaultValue=guest.addressLine1
                className="block w-full rounded-md border-0 py-1.5 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-inset focus:ring-gray-400 sm:text-sm sm:leading-6"
                onChange={(ev: JsxEvent.Form.t) => {
                  let target = JsxEvent.Form.target(ev)
                  let addressLine1 = target["value"]
                  setFormData(_prev => {...formData, addressLine1})
                }}
              />
            </div>
            <div className="sm:col-span-2">
              <label
                htmlFor="street-address-2"
                className="block text-sm font-medium leading-6 text-gray-950">
                {React.string("Apt, suite, etc.")}
              </label>
              <input
                id="street-address-2"
                type_="text"
                name="street-address-2"
                className="block w-full rounded-md border-0 py-1.5 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-inset focus:ring-gray-400 sm:text-sm sm:leading-6"
                defaultValue={switch guest.addressLine2 {
                | Some(line2) => line2
                | None => ""
                }}
                onChange={(ev: JsxEvent.Form.t) => {
                  let target = JsxEvent.Form.target(ev)
                  let addressLine2 = target["value"]
                  setFormData(_prev => {...formData, addressLine2})
                }}
              />
            </div>
            <div className="sm:col-span-2 sm:col-start-1">
              <label htmlFor="city" className="block text-sm font-medium leading-6 text-gray-950">
                {React.string("City")}
              </label>
              <input
                id="city"
                type_="text"
                name="city"
                required=true
                className="block w-full rounded-md border-0 py-1.5 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-inset focus:ring-gray-400 sm:text-sm sm:leading-6"
                defaultValue=guest.city
                onChange={(ev: JsxEvent.Form.t) => {
                  let target = JsxEvent.Form.target(ev)
                  let city = target["value"]
                  setFormData(_prev => {...formData, city})
                }}
              />
            </div>
            <div className="sm:col-span-2">
              <label htmlFor="state" className="block text-sm font-medium leading-6 text-gray-950">
                {React.string("State / Province")}
              </label>
              <input
                id="state"
                type_="text"
                name="state"
                required=true
                className="block w-full rounded-md border-0 py-1.5 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-inset focus:ring-gray-400 sm:text-sm sm:leading-6"
                defaultValue=guest.state
                onChange={(ev: JsxEvent.Form.t) => {
                  let target = JsxEvent.Form.target(ev)
                  let state = target["value"]
                  setFormData(_prev => {...formData, state})
                }}
              />
            </div>
            <div className="sm:col-span-2">
              <label htmlFor="zip" className="block text-sm font-medium leading-6 text-gray-950">
                {React.string("Postal code")}
              </label>
              <input
                id="zip"
                type_="text"
                name="zip"
                required=true
                className="block w-full rounded-md border-0 py-1.5 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-inset focus:ring-gray-400 sm:text-sm sm:leading-6"
                defaultValue=guest.zip
                minLength=5
                maxLength=5
                onChange={(ev: JsxEvent.Form.t) => {
                  let target = JsxEvent.Form.target(ev)
                  let zip = target["value"]
                  setFormData(_prev => {...formData, zip})
                }}
              />
            </div>
            <div className="sm:col-span-3">
              <label
                htmlFor="country" className="block text-sm font-medium leading-6 text-gray-950">
                {React.string("Country")}
              </label>
              <select
                id="country"
                name="country"
                required=true
                className="block w-full rounded-md border-0 py-1.5 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-inset focus:ring-gray-400 sm:text-sm sm:leading-6"
                value=guest.country
                onChange={(ev: JsxEvent.Form.t) => {
                  let target = JsxEvent.Form.target(ev)
                  let country = target["value"]
                  setFormData(_prev => {...formData, country})
                }}>
                <option value="" disabled=true> {React.string("Select one")} </option>
                <option> {React.string("United States")} </option>
                <option> {React.string("Canada")} </option>
                <option> {React.string("Mexico")} </option>
              </select>
            </div>
          </div>
          <div className="mt-8 flex justify-end">
            <button
              type_="submit"
              className="rounded-xl bg-gray-950 px-3 py-2 text-sm font-medium text-white shadow-sm hover:bg-gray-900">
              <span> {React.string("Save")} </span>
            </button>
          </div>
        </form>
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
