module Root = {
  @module("@radix-ui/react-dialog") @react.component
  external make: (
    ~defaultOpen: bool=?,
    @as("open") ~open_: bool=?,
    ~onOpenChange: (bool => bool) => unit=?,
    ~modal: bool=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "Root"
}

module Trigger = {
  @module("@radix-ui/react-dialog") @react.component
  external make: (
    ~asChild: bool=?,
    ~className: string=?,
    ~children: React.element,
    @as("data-state") ~dataState: [#"open" | #closed]=?,
  ) => React.element = "Trigger"
}

module Portal = {
  @module("@radix-ui/react-dialog") @react.component
  external make: (
    ~forceMount: bool=?,
    ~container: Dom.htmlElement=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "Portal"
}

module Overlay = {
  @module("@radix-ui/react-dialog") @react.component
  external make: (
    ~asChild: bool=?,
    ~forceMount: bool=?,
    ~container: Dom.htmlElement=?,
    ~className: string=?,
    @as("data-state") ~dataState: [#"open" | #closed]=?,
  ) => React.element = "Overlay"
}

module Content = {
  @module("@radix-ui/react-dialog") @react.component
  external make: (
    ~asChild: bool=?,
    ~forceMount: bool=?,
    ~onOpenAutoFocus: RadixTypes.onOpenAutoFocus=?,
    ~onCloseAutoFocus: RadixTypes.onCloseAutoFocus=?,
    ~onEscapeKeyDown: RadixTypes.onEscapeKeyDown=?,
    ~onPointerDownOutside: RadixTypes.onPointerDownOutside=?,
    ~onInteractOutside: RadixTypes.onInteractOutsideEvent=?,
    ~className: string=?,
    ~children: React.element,
    @as("data-state") ~dataState: [#"open" | #closed]=?,
  ) => React.element = "Content"
}

module Close = {
  @module("@radix-ui/react-dialog") @react.component
  external make: (
    ~asChild: bool=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "Close"
}

module Title = {
  @module("@radix-ui/react-dialog") @react.component
  external make: (
    ~asChild: bool=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "Title"
}

module Description = {
  @module("@radix-ui/react-dialog") @react.component
  external make: (
    ~asChild: bool=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "Description"
}
