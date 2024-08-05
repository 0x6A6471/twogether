type rsvpStatus =
  | @as("not_invited") NotInvited
  | @as("invited") Invited
  | @as("accepted") Accepted
  | @as("declined") Declined

@react.component
let make = (~guests: array<Models.Guest.t>) => {
  // <ul>
  //   {Array.map(guests, g => {
  //     let address = switch g.address_line_2 {
  //     | Some(line2) => g.address_line_1 ++ ", " ++ line2
  //     | None => g.address_line_1
  //     }
  //
  //     let status = switch g.rsvp_status {
  //     | #not_invited => "Not Invited"
  //     | #invited => "Invited"
  //     | #accepted => "Accepted"
  //     | #declined => "Declined"
  //     }
  //     let color = switch g.rsvp_status {
  //     | #not_invited => #gray
  //     | #invited => #yellow
  //     | #accepted => #green
  //     | #declined => #red
  //     }

  // })->React.array}
  // </ul>
  <div
    className="flex flex-col bg-white shadow-lg rounded-2xl" style={{height: "calc(100vh - 1rem)"}}>
    <div className="p-4 border-b border-gray-100">
      <h1 className="text-xl font-semibold text-gray-950"> {React.string("Guest List")} </h1>
    </div>
    <div className="flex-1 overflow-y-auto">
      <div className="p-4"> {React.string("Guest content")} </div>
    </div>
    <div className="p-4 border-t"> {React.string("extras")} </div>
  </div>
}
