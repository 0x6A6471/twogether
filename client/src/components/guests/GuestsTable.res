@react.component
let make = (~guests: array<Types.Guest.t>) => {
  <div className="px-4 sm:px-6 lg:px-8">
    // <div className="sm:flex sm:items-center">
    //   <div className="sm:flex-auto">
    //     <h1 className="text-base font-semibold leading-6 text-gray-900">Users</h1>
    //     <p className="mt-2 text-sm text-gray-700">
    //       A list of all the users in your account including their name, title, email and role.
    //     </p>
    //   </div>
    //   <div className="mt-4 sm:ml-16 sm:mt-0 sm:flex-none">
    //     <button
    //       type="button"
    //       className="block rounded-md bg-indigo-600 px-3 py-2 text-center text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
    //     >
    //       Add user
    //     </button>
    //   </div>
    // </div>
    <div className="mt-8 flow-root bg-white shadow rounded-xl">
      <div className="-mx-4 -my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
        <div className="inline-block min-w-full py-2 align-middle sm:px-6 lg:px-8">
          <div className="overflow-hidden shadow ring-1 ring-black ring-opacity-5 sm:rounded-lg">
            <table className="min-w-full">
              <thead className="bg-gray-950">
                <tr>
                  <th
                    scope="col"
                    className="py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-50 sm:pl-6">
                    {React.string("Name")}
                  </th>
                  <th
                    scope="col"
                    className="px-3 py-3.5 text-left text-sm font-semibold text-gray-50">
                    {React.string("Email")}
                  </th>
                  <th
                    scope="col"
                    className="px-3 py-3.5 text-left text-sm font-semibold text-gray-50">
                    {React.string("Address")}
                  </th>
                  <th
                    scope="col"
                    className="px-3 py-3.5 text-left text-sm font-semibold text-gray-50">
                    {React.string("Status")}
                  </th>
                  <th scope="col" className="relative py-3.5 pl-3 pr-4 sm:pr-6">
                    <span className="sr-only"> {React.string("Edit")} </span>
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-100">
                {Array.map(guests, g => {
                  Console.log2("Guest", g)
                  let address = switch Js.Nullable.toOption(g.address_line_2) {
                  | Some(line2) => g.address_line_1 ++ ", " ++ line2
                  | None => g.address_line_1
                  }

                  let status = switch g.rsvp_status {
                  | NotInvited => "Not Invited"
                  | Invited => "Invited"
                  | Accepted => "Accepted"
                  | Declined => "Declined"
                  }

                  let color = switch g.rsvp_status {
                  | NotInvited => #gray
                  | Invited => #yellow
                  | Accepted => #green
                  | Declined => #red
                  }

                  <tr key={g.id}>
                    <td
                      className="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6">
                      {React.string(g.first_name ++ " " ++ g.last_name)}
                    </td>
                    <td className="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                      {React.string(g.email)}
                    </td>
                    <td className="whitespace-nowrap px-3 py-4 text-sm text-gray-500">
                      <p> {React.string(address)} </p>
                      <p>
                        {React.string(
                          g.city ++ ", " ++ g.state ++ " " ++ g.zip ++ " " ++ g.country,
                        )}
                      </p>
                    </td>
                    <td className="whitespace-nowrap px-3 py-4">
                      <Ui.Badge label=status color />
                    </td>
                    <td
                      className="relative whitespace-nowrap py-4 pl-3 pr-4 text-right text-sm font-medium sm:pr-6">
                      <a href="#" className="text-indigo-600 hover:text-indigo-900">
                        {React.string("Edit")}
                      </a>
                    </td>
                  </tr>
                })->React.array}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
}
