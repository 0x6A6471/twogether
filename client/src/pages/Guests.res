let usePost = () => {
  ReactQuery.useQuery({
    queryKey: ["guests"],
    queryFn: _ => Models.Guest.fetchGuests(),
  })
}

@react.component
let make = () => {
  let {data, isFetching} = usePost()

  <div>
    {switch (data, isFetching) {
    | (_, true) => `Loading...`->React.string
    | (Ok(guests), false) =>
      switch guests {
      | _ => <Guests.GuestsList guests />
      }
    | (Error(err), false) => <pre> {React.string(err)} </pre>
    }}
  </div>
}
