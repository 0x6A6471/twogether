module Fetch = {
  type response

  @send external json: response => Js.Promise.t<'a> = "json"
  @val external fetch: string => Js.Promise.t<response> = "fetch"
}

type t = {id: string, first_name: string, last_name: string, email: string}

let apiUrl = "http://localhost:8080/api/guests"

@react.component
let make = () => {
  let {data, isError, isLoading} = ReactQuery.useQuery({
    queryKey: ["guests"],
    queryFn: _ => Fetch.fetch(apiUrl)->Promise.then(Fetch.json),
    refetchOnWindowFocus: ReactQuery.refetchOnWindowFocus(#bool(false)),
  })

  <div>
    {switch (data, isError, isLoading) {
    | (_, _, true) => `Loading...`->React.string
    | (_, true, _) => `Error fetching data...`->React.string
    | (Some(guests), false, false) =>
      <ul role="list" className="-mx-2 space-y-1">
        {Array.map(guests, g => {
          <li key={g.id}>
            <span> {React.string(g.first_name ++ " " ++ g.last_name)} </span>
            <span> {React.string(" - " ++ g.email)} </span>
          </li>
        })->React.array}
      </ul>
    | (None, false, false) =>
      <ul role="list" className="-mx-2 space-y-1">
        <p> {React.string("No guests found...")} </p>
      </ul>
    }}
  </div>
}
