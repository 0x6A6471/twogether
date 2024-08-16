type t = [
  | #gray
  | #green
  | #red
  | #yellow
]

@react.component
let make: (~label: string, ~color: t=?) => Jsx.element
