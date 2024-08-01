@react.component
let make = () => {
  let {data, error, isError, isLoading} = ReactQuery.useQuery({
    queryKey: ["guests"],
    queryFn: _ => Models.Guest.fetchGuests(),
    refetchOnWindowFocus: ReactQuery.refetchOnWindowFocus(#bool(false)),
  })

  <div>
    {switch (data, isError, isLoading) {
    | (_, _, true) => `Loading...`->React.string
    | (_, true, _) =>
      Console.error(error)
      React.string(`Error fetching data`)

    | (Some(guests), false, false) =>
      switch guests {
      | Ok(guests) => <GuestsTable guests />
      | Error(_err) => <p> {React.string("error")} </p>
      }
    | (None, false, false) =>
      <ul role="list" className="-mx-2 space-y-1">
        <p> {React.string("No guests found...")} </p>
      </ul>
    }}
  </div>
}
