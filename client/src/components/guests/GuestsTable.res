type rsvpStatus =
  | @as("not_invited") NotInvited
  | @as("invited") Invited
  | @as("accepted") Accepted
  | @as("declined") Declined

@react.component
let make = (~guests: array<Models.Guest.t>) => {
  <ul>
    {Array.map(guests, g => {
      let address = switch g.address_line_2 {
      | Some(line2) => g.address_line_1 ++ ", " ++ line2
      | None => g.address_line_1
      }

      let status = switch g.rsvp_status {
      | #not_invited => "Not Invited"
      | #invited => "Invited"
      | #accepted => "Accepted"
      | #declined => "Declined"
      }
      let color = switch g.rsvp_status {
      | #not_invited => #gray
      | #invited => #yellow
      | #accepted => #green
      | #declined => #red
      }

      <li key=g.id>
        <p> {React.string(g.first_name ++ " " ++ g.last_name)} </p>
        <p> {React.string(g.email)} </p>
        <p> {React.string(address)} </p>
        <p> {React.string(g.city ++ ", " ++ g.state ++ g.zip ++ " " ++ g.country)} </p>
        <Ui.Badge label=status color />
      </li>
    })->React.array}
  </ul>
}
