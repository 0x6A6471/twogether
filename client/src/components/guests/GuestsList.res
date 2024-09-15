@val
external navigator: {"clipboard": {"writeText": string => Promise.t<unit>}} = "navigator"

let copyToClipboard = (text: string) => {
  navigator["clipboard"]["writeText"](text)->ignore
}
@react.component
let make = (~guests: array<Models.Guest.t>) => {
  switch guests {
  | [] => <EmptyState />
  | _ =>
    <ul role="list" className="divide-y divide-gray-100 border border-gray-100 rounded-2xl">
      {Array.map(guests, g => {
        let address = switch g.addressLine2 {
        | Some(line2) => g.addressLine1 ++ ", " ++ line2
        | None => g.addressLine1
        }

        let status = switch g.rsvpStatus {
        | #not_invited => "Not Invited"
        | #invited => "Invited"
        | #accepted => "Accepted"
        | #declined => "Declined"
        }
        let color = switch g.rsvpStatus {
        | #not_invited => #gray
        | #invited => #yellow
        | #accepted => #green
        | #declined => #red
        }

        <li key={g.id} className="flex items-center justify-between gap-x-6 p-4">
          <div className="min-w-0">
            <div className="flex items-start gap-x-3">
              <p className="text-sm font-semibold leading-6 text-gray-900">
                {React.string(g.firstName ++ " " ++ g.lastName)}
              </p>
              <Ui.Badge label=status color />
            </div>
            <div className="mt-1 flex items-center gap-x-2 text-xs leading-5 text-gray-500">
              <p className="whitespace-nowrap"> {React.string(address)} </p>
              <svg viewBox="0 0 2 2" className="h-0.5 w-0.5 fill-current">
                <circle r="1" cx="1" cy="1" />
              </svg>
              <p className="truncate"> {React.string(Utils.formatDateString(g.createdAt))} </p>
            </div>
          </div>
          <div className="flex flex-none items-center gap-x-1">
            <Ui.ButtonTooltip
              label="Copy Email" icon="email" onClick={_ => copyToClipboard(g.email)}
            />
            <EditGuestDialog guest=g />
            <DeleteGuestDialog guest=g />
          </div>
        </li>
      })->React.array}
    </ul>
  }
}
