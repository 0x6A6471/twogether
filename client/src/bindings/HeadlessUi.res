module Dialog = {
  type role = [
    | #dialog
    | #alertdialog
  ]

  @module("@headlessui/react") @react.component
  external make: (
    @as("open") ~open_: bool,
    ~onClose: (bool => bool) => unit,
    @as("as") ~as_: string=?,
    ~autoFocus: bool=?,
    ~transition: bool=?,
    ~static: bool=?,
    ~unmount: bool=?,
    ~role: role=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "Dialog"
}

module DialogBackdrop = {
  @module("@headlessui/react") @react.component
  external make: (
    @as("as") ~as_: string=?,
    ~transition: bool=?,
    ~className: string=?,
  ) => React.element = "DialogBackdrop"
}

module DialogPanel = {
  @module("@headlessui/react") @react.component
  external make: (
    @as("as") ~as_: string=?,
    ~transition: bool=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "DialogPanel"
}

module DialogTitle = {
  @module("@headlessui/react") @react.component
  external make: (
    @as("as") ~as_: string=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "DialogTitle"
}

module Description = {
  @module("@headlessui/react") @react.component
  external make: (
    @as("as") ~as_: string=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "DialogDescription"
}

module CloseButton = {
  @module("@headlessui/react") @react.component
  external make: (
    @as("as") ~as_: string=?,
    ~className: string=?,
    ~children: React.element,
  ) => React.element = "CloseButton"
}

module TransitionChild = {
  @module("@headlessui/react") @react.component
  external make: (
    @as("as") ~as_: string=?,
    ~appear: bool=?,
    ~unmount: bool=?,
    ~children: React.element,
  ) => React.element = "TransitionChild"
}
