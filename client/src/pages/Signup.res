type t = {
  name: string,
  email: string,
  password: string,
  password2: string,
}

let initialState: t = {
  name: "",
  email: "",
  password: "",
  password2: "",
}

@react.component
let make = () => {
  let (formData, setFormData) = React.useState(_ => initialState)

  let onSubmit = (e: ReactEvent.Form.t) => {
    e->ReactEvent.Form.preventDefault
    Js.log(formData)
  }

  <form className="max-w-sm mx-auto mt-20 space-y-4" onSubmit>
    <div>
      <label htmlFor="name" className="block text-sm font-medium leading-6 text-gray-900">
        {React.string("Name")}
      </label>
      <div>
        <input
          id="name"
          name="name"
          type_="text"
          placeholder="Jane Doe"
          autoFocus=true
          className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
          onChange={(ev: JsxEvent.Form.t) => {
            let target = JsxEvent.Form.target(ev)
            let name: string = target["value"]
            setFormData(_prev => {...formData, name})
          }}
        />
      </div>
    </div>
    <div>
      <label htmlFor="email" className="block text-sm font-medium leading-6 text-gray-900">
        {React.string("Email")}
      </label>
      <div>
        <input
          id="email"
          name="email"
          type_="email"
          placeholder="you@example.com"
          className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
          onChange={(ev: JsxEvent.Form.t) => {
            let target = JsxEvent.Form.target(ev)
            let email: string = target["value"]
            setFormData(_prev => {...formData, email})
          }}
        />
      </div>
    </div>
    <div>
      <label htmlFor="password" className="block text-sm font-medium leading-6 text-gray-900">
        {React.string("Password")}
      </label>
      <div>
        <input
          id="password"
          name="password"
          type_="password"
          placeholder="password"
          className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
          onChange={(ev: JsxEvent.Form.t) => {
            let target = JsxEvent.Form.target(ev)
            let password: string = target["value"]
            setFormData(_prev => {...formData, password})
          }}
        />
      </div>
    </div>
    <div>
      <label htmlFor="password2" className="block text-sm font-medium leading-6 text-gray-900">
        {React.string("Confirm password")}
      </label>
      <div>
        <input
          id="password2"
          name="password2"
          type_="password"
          placeholder="confirm password"
          className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
          onChange={(ev: JsxEvent.Form.t) => {
            let target = JsxEvent.Form.target(ev)
            let password2: string = target["value"]
            setFormData(_prev => {...formData, password2})
          }}
        />
      </div>
    </div>
    <button type_="submit"> {React.string("Submit")} </button>
  </form>
}
