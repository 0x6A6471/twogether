module Dialog = struct
  type role =
    [ `dialog
    | `alertdialog
    ]

  external make
    :  open_:(bool[@mel.as "open"])
    -> onClose:((bool -> bool) -> unit)
    -> ?as_:(string[@mel.as "as"])
    -> ?autoFocus:bool
    -> ?transition:bool
    -> ?static:bool
    -> ?unmount:bool
    -> ?role:role
    -> ?children:React.element
    -> ?className:string
    -> React.element
    = "Dialog"
  [@@react.component] [@@mel.module "@headlessui/react"]
end

module DialogBackdrop = struct
  external make
    :  ?as_:(string[@mel.as "as"])
    -> ?transition:bool
    -> ?className:string
    -> React.element
    = "DialogBackdrop"
  [@@react.component] [@@mel.module "@headlessui/react"]
end

module DialogPanel = struct
  external make
    :  ?as_:(string[@mel.as "as"])
    -> ?transition:bool
    -> ?className:string
    -> ?children:React.element
    -> React.element
    = "DialogPanel"
  [@@react.component] [@@mel.module "@headlessui/react"]
end

module DialogTitle = struct
  external make
    :  ?as_:(string[@mel.as "as"])
    -> ?className:string
    -> children:React.element
    -> React.element
    = "DialogTitle"
  [@@react.component] [@@mel.module "@headlessui/react"]
end

module Description = struct
  external make
    :  ?as_:(string[@mel.as "as"])
    -> ?className:string
    -> children:React.element
    -> React.element
    = "DialogDescription"
  [@@react.component] [@@mel.module "@headlessui/react"]
end

module CloseButton = struct
  external make
    :  ?as_:(string[@mel.as "as"])
    -> ?className:string
    -> children:React.element
    -> React.element
    = "CloseButton"
  [@@react.component] [@@mel.module "@headlessui/react"]
end

module TransitionChild = struct
  external make
    :  ?as_:(string[@mel.as "as"])
    -> ?appear:bool
    -> ?unmount:bool
    -> ?children:React.element
    -> React.element
    = "TransitionChild"
  [@@react.component] [@@mel.module "@headlessui/react"]
end
