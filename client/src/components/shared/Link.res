@react.component
let make = (~href: string, ~className: option<string>=?, ~children: React.element) => {
  let className = switch className {
  | Some(classes) => classes
  | None => ""
  }

  <a
    href={href}
    onClick={e => {
      e->ReactEvent.Mouse.preventDefault
      RescriptReactRouter.push(href)
    }}
    className>
    children
  </a>
}
