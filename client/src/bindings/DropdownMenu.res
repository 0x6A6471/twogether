module Root = {
  type dir = [
    | #ltr
    | #rtl
  ]

  @module("@radix-ui/react-dropdown-menu") @react.component
  external make: (
    ~defaultOpen: bool=?,
    @as("open") ~open_: bool=?,
    ~onOpenChange: (bool => bool) => unit=?,
    ~dir: dir=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "Root"
}

module Trigger = {
  @module("@radix-ui/react-dropdown-menu") @react.component
  external make: (
    ~asChild: bool=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "Trigger"
}

module Portal = {
  @module("@radix-ui/react-dropdown-menu") @react.component
  external make: (
    ~forceMount: bool=?,
    ~container: Dom.htmlElement=?,
    ~children: React.element,
  ) => React.element = "Portal"
}

module Content = {
  @module("@radix-ui/react-dropdown-menu") @react.component
  external make: (
    ~asChild: bool=?,
    ~loop: bool=?,
    ~onCloseAutoFocus: RadixTypes.onCloseAutoFocus=?,
    ~onEscapeKeyDown: RadixTypes.onEscapeKeyDown=?,
    ~onPointerDownOutside: RadixTypes.onPointerDownOutside=?,
    ~onFocusOutside: RadixTypes.onFocusOutside=?,
    ~onInteractOutside: RadixTypes.onInteractOutsideEvent=?,
    ~forceMount: bool=?,
    ~side: RadixTypes.side=?,
    ~sideOffset: int=?,
    ~align: RadixTypes.align=?,
    ~alignOffset: int=?,
    ~avoidCollisions: bool=?,
    ~collissionBoundary: RadixTypes.collisionBoundary=?,
    ~collissionPadding: RadixTypes.collissionPadding=?,
    ~arrowPadding: int=?,
    ~sticky: RadixTypes.sticky=?,
    ~hideWhenDetached: bool=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "Content"
}

module Arrow = {
  @module("@radix-ui/react-dropdown-menu") @react.component
  external make: (
    ~asChild: bool=?,
    ~width: int=?,
    ~height: int=?,
    ~className: string=?,
  ) => React.element = "Arrow"
}

module Item = {
  @module("@radix-ui/react-dropdown-menu") @react.component
  external make: (
    ~asChild: bool=?,
    ~disabled: bool=?,
    ~onSelect: ReactEvent.synthetic<'a> => unit=?,
    ~textValue: string=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "Item"
}

module Group = {
  @module("@radix-ui/react-dropdown-menu") @react.component
  external make: (~asChild: bool=?) => React.element = "Group"
}

module Label = {
  @module("@radix-ui/react-dropdown-menu") @react.component
  external make: (
    ~asChild: bool=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "Label"
}

module CheckboxItem = {
  @module("@radix-ui/react-dropdown-menu") @react.component
  type checked = [
    | #Bool(bool)
    | #Indeterminate
  ]
  external make: (
    ~asChild: bool=?,
    ~checked: checked=?,
    ~onCheckedChanged: bool => unit=?,
    ~disabled: bool=?,
    ~onSelect: ReactEvent.synthetic<'a> => unit=?,
    ~textValue: string=?,
    ~className: string=?,
  ) => React.element = "CheckboxItem"
}

module RadioGroup = {
  @module("@radix-ui/react-dropdown-menu") @react.component
  external make: (
    ~asChild: bool=?,
    ~value: string,
    ~onValueChange: string => unit=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "RadioGroup"
}

module RadioItem = {
  @module("@radix-ui/react-dropdown-menu") @react.component
  external make: (
    ~asChild: bool=?,
    ~value: string,
    ~disabled: bool=?,
    ~onSelect: ReactEvent.synthetic<'a> => unit=?,
    ~textValue: string=?,
    ~onValueChange: string => unit=?,
  ) => React.element = "RadioItem"
}

module ItemIndicator = {
  @module("@radix-ui/react-dropdown-menu") @react.component
  external make: (~asChild: bool=?, ~forceMount: bool=?) => React.element = "ItemIndicator"
}

module Separator = {
  @module("@radix-ui/react-dropdown-menu") @react.component
  external make: (~asChild: bool=?) => React.element = "Separator"
}

module Sub = {
  @module("@radix-ui/react-dropdown-menu") @react.component
  external make: (
    ~asChild: bool=?,
    @as("open") ~open_: bool,
    ~onOpenChange: bool => unit,
  ) => React.element = "Sub"
}

module SubTrigger = {
  @module("@radix-ui/react-dropdown-menu") @react.component
  external make: (
    ~asChild: bool=?,
    ~disabled: bool=?,
    ~textValue: string=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "SubTrigger"
}

module SubContent = {
  @module("@radix-ui/react-dropdown-menu") @react.component
  type side = [
    | #top
    | #right
    | #bottom
    | #left
  ]

  type align = [
    | #start
    | #center
    | #end
  ]

  type collisionBoundary =
    | SingleElement(option<Dom.element>)
    | ElementArray(array<option<Dom.element>>)

  type collissionPadding =
    | Number(float)
    | PartialRecord(Js.Dict.t<float>)

  type sticky = [
    | #partial
    | #always
  ]

  external make: (
    ~asChild: bool=?,
    ~loop: bool=?,
    ~onCloseAuthFocus: ReactEvent.synthetic<'a> => unit=?,
    ~onEscapeKeyDown: ReactEvent.Keyboard.t => unit=?,
    ~onPointerDownOutside: ReactEvent.Pointer.t => unit=?,
    ~onFocusOutside: ReactEvent.Focus.t => unit=?,
    ~onInteractOutside: RadixTypes.onInteractOutsideEvent=?,
    ~forceMount: bool=?,
    ~side: side=?,
    ~sideOffset: int=?,
    ~align: align=?,
    ~alignOffset: int=?,
    ~avoidCollisions: bool=?,
    ~collissionBoundary: collisionBoundary=?,
    ~collissionPadding: collissionPadding=?,
    ~arrowPadding: int=?,
    ~sticky: sticky=?,
    ~hideWhenDetached: bool=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "SubContent"
}
