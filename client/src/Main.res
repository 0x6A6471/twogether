%%raw("import './index.css'")

switch ReactDOM.querySelector("#root") {
| Some(domElement) =>
  ReactDOM.Client.createRoot(domElement)->ReactDOM.Client.Root.render(
    <React.StrictMode>
      <AuthContext.Provider>
        <App />
      </AuthContext.Provider>
    </React.StrictMode>,
  )
| None => ()
}
