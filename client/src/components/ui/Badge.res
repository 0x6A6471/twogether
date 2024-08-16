type t = [
  | #gray
  | #green
  | #red
  | #yellow
]

@react.component
let make = (~label: string, ~color=#gray) => {
  let color = switch color {
  | #gray => "bg-gray-50 text-gray-700 ring-gray-700/10"
  | #green => "bg-green-50 text-green-700 ring-green-700/10"
  | #red => "bg-rose-50 text-rose-700 ring-rose-700/10"
  | #yellow => "bg-yellow-50 text-yellow-700 ring-yellow-700/10"
  }

  <span
    className={`${color} inline-flex items-center rounded-full px-2 py-1 text-xs font-medium ring-1 ring-inset`}>
    {React.string(label)}
  </span>
}
