@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  switch url.path {
  | list{"dashboard"} => <Dashboard />
  | list{} => <HomePage />
  | _ => <FourOhFour />
  }
}
