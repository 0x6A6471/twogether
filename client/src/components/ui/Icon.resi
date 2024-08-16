type t = [
  | #line
  | #filled
]

@react.component
let make: (~name: string, ~className: string=?, ~variant: t=?, ~size: string=?) => Jsx.element
