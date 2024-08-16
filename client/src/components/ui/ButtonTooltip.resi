type t = [#gray | #red]

@react.component
let make: (~label: string, ~icon: string, ~color: t=?, ~onClick: unit => unit) => Jsx.element
