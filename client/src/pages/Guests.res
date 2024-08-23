let usePost = () => {
  ReactQuery.useQuery({
    queryKey: ["guests"],
    queryFn: _ => Models.Guest.fetchGuests(),
  })
}

@react.component
let make = () => {
  let {data, isFetching} = usePost()

  <div className="flex flex-col bg-white rounded-2xl" style={{height: "calc(100vh - 1rem)"}}>
    <div className="flex justify-between items-center p-4 border-b border-gray-100">
      <h1 className="text-xl font-semibold text-gray-950"> {React.string("Guest List")} </h1>
      <GuestDialog triggerText="New" />
    </div>
    <div className="flex-1 overflow-y-auto m-4">
      {switch (data, isFetching) {
      | (_, true) =>
        <div className="flex items-center justify-center h-full">
          <Ui.Icon className="animate-spin text-black" name="loader" size="24" />
        </div>
      | (Ok(guests), false) => <GuestsList guests />
      | (Error(err), false) => <pre> {React.string(err)} </pre>
      }}
    </div>
    <div className="p-4 border-t border-gray-100"> {React.string("extras")} </div>
  </div>
}
