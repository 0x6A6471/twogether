let initialState: AuthContext.formData = {
  email: "",
  password: "",
}

@react.component
let make = () => {
  let (formData, setFormData) = React.useState(_ => initialState)
  let (isLoading, setIsLoading) = React.useState(_ => false)
  let (error, setError) = React.useState(_ => None)
  let {login} = AuthContext.useAuth()

  React.useEffect(() => {
    setError(_ => None)
    None
  }, [formData])

  // TODO: switch on the status of the request?
  // async/await?
  let onSubmit = (e: ReactEvent.Form.t) => {
    e->ReactEvent.Form.preventDefault
    setIsLoading(_ => true)
    login(formData)
    ->Promise.then(data => {
      switch Js.Json.decodeObject(data) {
      | Some(obj) =>
        switch Js.Dict.get(obj, "error") {
        | Some(error) =>
          switch Js.Json.decodeString(error) {
          | Some(msg) =>
            setError(_ => Some(msg))
            setIsLoading(_ => false)
            Promise.resolve()
          | None =>
            setError(_ => Some("An error occurred, but details are unavailable."))
            setIsLoading(_ => false)
            Promise.resolve()
          }
        | None =>
          setError(_ => None)
          setIsLoading(_ => false)
          Promise.resolve()
        }
      | None =>
        setError(_ => Some("Invalid response format"))
        setIsLoading(_ => false)
        Promise.resolve()
      }
    })
    ->ignore
  }

  let error = switch error {
  | Some(error) => <p className="text-red-600 text-sm"> {React.string(error)} </p>
  | None => React.null
  }

  <div className="pt-20">
    <form className="max-w-sm mx-auto space-y-4 bg-white p-4 rounded-lg shadow-lg" onSubmit>
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
            autoFocus=true
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
        {error}
      </div>
      <button type_="submit" disabled={isLoading}>
        {isLoading ? React.string("Loading...") : React.string("Log in")}
      </button>
    </form>
  </div>
}
