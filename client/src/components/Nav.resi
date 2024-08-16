type t = {
  name: string,
  href: string,
  icon: string,
}

@react.component
let make: (~children: React.element) => Jsx.element
