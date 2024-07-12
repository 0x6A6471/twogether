%%raw("import './index.css'")

switch ReactDOM.querySelector("#root") {
| Some(domElement) =>
  ReactDOM.Client.createRoot(domElement)->ReactDOM.Client.Root.render(
    <React.StrictMode>
      <Clerk.ClerkProvider publishableKey={Env.clerkPublishableKey}>
        <AuthContext.Provider>
          <App />
        </AuthContext.Provider>
      </Clerk.ClerkProvider>
    </React.StrictMode>,
  )
| None => ()
}
