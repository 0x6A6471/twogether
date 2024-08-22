%%raw("import './index.css'")

let client = ReactQuery.QueryClient.make()

switch ReactDOM.querySelector("#root") {
| Some(domElement) =>
  ReactDOM.Client.createRoot(domElement)->ReactDOM.Client.Root.render(
    <React.StrictMode>
      <ReactQuery.QueryClientProvider client={client}>
        <AuthContext.Provider>
          <App />
        </AuthContext.Provider>
      </ReactQuery.QueryClientProvider>
    </React.StrictMode>,
  )
| None => ()
}
