type variant = [
  | #filled
]

@react.component
let make = (
  ~name: string,
  ~variant: option<variant>=?,
  ~className: option<string>=?,
  ~size: string="16",
) => {
  let name = switch variant {
  | Some(#filled) => name ++ "-filled"
  | None => name
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
