type t = [
  | #line
  | #filled
]

@react.component
let make = (~name: string, ~className: option<string>=?, ~variant: t=#line, ~size: string="16") => {
  let name = switch variant {
  | #filled => name ++ "-filled"
  | #line => name
  }

  <svg
    className={switch className {
    | Some(className) => className
    | None => ""
    }}
    height=size
    width=size>
    <use href={`/sprite.svg#${name}`} height=size width=size />
  </svg>
}
