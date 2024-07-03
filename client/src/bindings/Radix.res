module Label = {
  @module("@radix-ui/react-label") @react.component
  external make: (
    ~htmlFor: string,
    ~_asChild: bool=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "Label"
}
