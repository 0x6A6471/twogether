module Provider = {
  @module("@radix-ui/react-tooltip") @react.component
  external make: (
    ~delayDuration: int=?,
    ~skipDelayDuration: int=?,
    ~disableHoverableContent: bool=?,
    ~children: React.element,
  ) => React.element = "Provider"
}

module Root = {
  @module("@radix-ui/react-tooltip") @react.component
  external make: (
    ~defaultOpen: bool=?,
    @as("open") ~open_: bool=?,
    ~onOpenChange: (bool => bool) => unit=?,
    ~delayDuration: int=?,
    ~disableHoverableContent: bool=?,
    ~children: React.element,
  ) => React.element = "Root"
}

module Trigger = {
  @module("@radix-ui/react-tooltip") @react.component
  external make: (
    ~asChild: bool=?,
    ~className: string=?,
    ~children: React.element,
    @as("data-state") ~dataState: [#closed | #"delayed-open" | #"instant-open"]=?,
  ) => React.element = "Trigger"
}

module Portal = {
  @module("@radix-ui/react-tooltip") @react.component
  external make: (
    ~forceMount: bool=?,
    ~container: Dom.htmlElement=?,
    ~children: React.element,
  ) => React.element = "Portal"
}

module Content = {
  @module("@radix-ui/react-tooltip") @react.component
  external make: (
    ~asChild: bool=?,
    @as("aria-label") ~ariaLabel: string=?,
    ~onEscapeKeyDown: ReactEvent.Keyboard.t => unit=?,
    ~onPointerDownOutside: ReactEvent.Pointer.t => unit=?,
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
    @as("data-state") ~dataState: [#closed | #"delayed-open" | #"instant-open"]=?,
    @as("data-side") ~dataSide: [#left | #right | #bottom | #top]=?,
    @as("data-align") ~dataAlign: [#start | #end | #center]=?,
  ) => React.element = "Content"
}

module Arrow = {
  @module("@radix-ui/react-tooltip") @react.component
  external make: (
    ~asChild: bool=?,
    ~width: int=?,
    ~height: int=?,
    ~className: string=?,
  ) => React.element = "Arrow"
}
