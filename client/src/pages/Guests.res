let fetchGuests = (_): Js.Promise.t<array<Types.Guest.t>> => {
  Query.fetch("http://localhost:8080/api/guests")->Promise.then(Query.json)
}

@react.component
let make = () => {
  let {data, isError, isLoading} = ReactQuery.useQuery({
    queryKey: ["guests"],
    queryFn: _ => fetchGuests(),
    refetchOnWindowFocus: ReactQuery.refetchOnWindowFocus(#bool(false)),
  })

  <div>
    {switch (data, isError, isLoading) {
    | (_, _, true) => `Loading...`->React.string
    | (_, true, _) => `Error fetching data...`->React.string
    | (Some(guests), false, false) => <GuestsTable guests />
    | (None, false, false) =>
      <ul role="list" className="-mx-2 space-y-1">
        <p> {React.string("No guests found...")} </p>
      </ul>
    }}
  </div>
}
