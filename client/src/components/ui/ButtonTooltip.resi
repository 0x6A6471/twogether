type color = [#gray | #red]

@react.component
let make: (~label: string, ~icon: string, ~color: color=?, ~onClick: unit => unit) => Jsx.element
