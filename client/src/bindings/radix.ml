module Types = struct
  type align =
    [ `start
    | `center
    | `endd
    ]

  type focus_event = React.Event.Focus.t -> unit
  type keyboard_event = React.Event.Keyboard.t -> unit
  type pointer_event = React.Event.Pointer.t -> unit
  type synthetic_event = React.Event.Synthetic.t -> unit

  type side =
    [ `top
    | `right
    | `bottom
    | `left
    ]

  type sticky =
    [ `partial
    | `always
    ]

  type on_interact_outside_event =
    [ `PointerDownOutside of pointer_event -> unit
    | `FocusOutside of focus_event -> unit
    ]

  type collision_boundary =
    [ `SingleElement of Dom.element option
    | `ElementArray of Dom.element option array
    ]

  type collision_padding =
    [ `Number of float
    | `PartialRecord of float Js.Dict.t
    ]
end

module DropdownMenu = struct
  module Root = struct
    type dir =
      [ `ltr
      | `rtl
      ]

    external make
      :  open_:(bool[@mel.as "open"])
      -> ?defaultOpen:bool
      -> ?onOpenChange:((bool -> bool) -> unit)
      -> ?dir:dir
      -> ?className:string
      -> ?children:React.element
      -> React.element
      = "Root"
    [@@react.component] [@@mel.module "@radix-ui/react-dropdown-menu"]
  end

  module Trigger = struct
    external make
      :  asChild:bool
      -> ?className:string
      -> children:React.element
      -> React.element
      = "Trigger"
    [@@react.component] [@@mel.module "@radix-ui/react-dropdown-menu"]
  end

  module Portal = struct
    external make
      :  ?forceMount:bool
      -> ?container:Dom.htmlElement
      -> children:React.element
      -> React.element
      = "Portal"
    [@@react.component] [@@mel.module "@radix-ui/react-dropdown-menu"]
  end

  module Content = struct
    external make
      :  ?asChild:bool
      -> ?loop:bool
      -> ?onCloseAutoFocus:Types.focus_event
      -> ?onEscapeKeyDown:Types.keyboard_event
      -> ?onPointerDownOutside:Types.pointer_event
      -> ?onFocusOutside:Types.focus_event
      -> ?onInteractOutside:Types.on_interact_outside_event
      -> ?forceMount:bool
      -> ?side:Types.side
      -> ?sideOffset:int
      -> ?align:Types.align
      -> ?alignOffset:int
      -> ?avoidCollisions:bool
      -> ?collissionBoundary:Types.collision_boundary
      -> ?collissionPadding:Types.collision_padding
      -> ?arrowPadding:int
      -> ?sticky:Types.sticky
      -> ?hideWhenDetached:bool
      -> ?className:string
      -> children:React.element
      -> React.element
      = "Content"
    [@@react.component] [@@mel.module "@radix-ui/react-dropdown-menu"]
  end

  module Arrow = struct
    external make
      :  ?asChild:bool
      -> ?width:int
      -> ?height:int
      -> ?className:string
      -> React.element
      = "Arrow"
    [@@react.component] [@@mel.module "@radix-ui/react-dropdown-menu"]
  end

  module Item = struct
    external make
      :  ?asChild:bool
      -> ?disabled:bool
      -> ?onSelect:Types.synthetic_event
      -> ?textValue:string
      -> ?className:string
      -> children:React.element
      -> React.element
      = "Item"
    [@@react.component] [@@mel.module "@radix-ui/react-dropdown-menu"]
  end

  module Group = struct
    external make : ?asChild:bool -> React.element = "Group"
    [@@react.component] [@@mel.module "@radix-ui/react-dropdown-menu"]
  end

  module Label = struct
    external make
      :  ?asChild:bool
      -> ?className:string
      -> children:React.element
      -> React.element
      = "Label"
    [@@react.component] [@@mel.module "@radix-ui/react-dropdown-menu"]
  end

  module CheckboxItem = struct
    type checked =
      [ `Bool of bool
      | `Indeterminate
      ]

    external make
      :  ?asChild:bool
      -> ?checked:checked
      -> ?onCheckedChanged:bool
      -> unit
      -> ?disabled:bool
      -> ?onSelect:Types.synthetic_event
      -> ?textValue:string
      -> ?className:string
      -> React.element
      = "CheckboxItem"
    [@@react.component] [@@mel.module "@radix-ui/react-dropdown-menu"]
  end

  module RadioGroup = struct
    external make
      :  ?asChild:bool
      -> value:string
      -> ?onValueChange:string
      -> unit
      -> ?className:string
      -> children:React.element
      -> React.element
      = "RadioGroup"
    [@@react.component] [@@mel.module "@radix-ui/react-dropdown-menu"]
  end

  module RadioItem = struct
    external make
      :  ?asChild:bool
      -> value:string
      -> ?disabled:bool
      -> ?onSelect:Types.synthetic_event
      -> ?textValue:string
      -> ?onValueChange:string
      -> uni
      -> React.element
      = "RadioItem"
    [@@react.component] [@@mel.module "@radix-ui/react-dropdown-menu"]
  end

  module ItemIndicator = struct
    external make
      :  ?asChild:bool
      -> ?forceMount:bool
      -> React.element
      = "ItemIndicator"
    [@@react.component] [@@mel.module "@radix-ui/react-dropdown-menu"]
  end

  module Separator = struct
    external make : ?asChild:bool -> React.element = "Separator"
    [@@react.component] [@@mel.module "@radix-ui/react-dropdown-menu"]
  end

  module Sub = struct
    external make
      :  ?asChild:bool
      -> ?open_:(bool[@mel.as "open"])
      -> onOpenChange:bool
      -> unit
      -> React.element
      = "Sub"
    [@@react.component] [@@mel.module "@radix-ui/react-dropdown-menu"]
  end

  module SubTrigger = struct
    external make
      :  asChild:bool
      -> ?disabled:bool
      -> ?textValue:string
      -> ?className:string
      -> children:React.element
      -> React.element
      = "SubTrigger"
    [@@react.component] [@@mel.module "@radix-ui/react-dropdown-menu"]
  end

  module SubContent = struct
    external make
      :  ?asChild:bool
      -> ?loop:bool
      -> ?onCloseAuthFocus:Types.synthetic_event
      -> ?onEscapeKeyDown:Types.keyboard_event
      -> ?onPointerDownOutside:Types.pointer_event
      -> ?onFocusOutside:Types.focus_event
      -> ?onInteractOutside:Types.on_interact_outside_event
      -> ?forceMount:bool
      -> ?side:Types.side
      -> ?sideOffset:int
      -> ?align:Types.align
      -> ?alignOffset:int
      -> ?avoidCollisions:bool
      -> ?collissionBoundary:Types.collision_boundary
      -> ?collissionPadding:Types.collision_padding
      -> ?arrowPadding:int
      -> ?sticky:Types.sticky
      -> ?hideWhenDetached:bool
      -> ?className:string
      -> children:React.element
      -> React.element
      = "SubContent"
    [@@react.component] [@@mel.module "@radix-ui/react-dropdown-menu"]
  end
end

module Dialog = struct
  module Root = struct
    external make
      :  ?open_:(bool[@mel.as "open"])
      -> ?defaultOpen:bool
      -> ?onOpenChange:((bool -> bool) -> unit)
      -> ?modal:bool
      -> ?className:string
      -> ?children:React.element
      -> React.element
      = "Root"
    [@@react.component] [@@mel.module "@radix-ui/react-dialog"]
  end

  module Trigger = struct
    external make
      :  asChild:bool
      -> ?className:string
      -> children:React.element
      -> React.element
      = "Trigger"
    [@@react.component] [@@mel.module "@radix-ui/react-dialog"]
  end

  module Portal = struct
    external make
      :  ?forceMount:bool
      -> ?container:Dom.htmlElement
      -> children:React.element
      -> React.element
      = "Portal"
    [@@react.component] [@@mel.module "@radix-ui/react-dialog"]
  end

  module Overlay = struct
    external make
      :  ?asChild:bool
      -> ?forceMount:bool
      -> ?container:Dom.htmlElement
      -> ?className:string
      -> React.element
      = "Overlay"
    [@@react.component] [@@mel.module "@radix-ui/react-dialog"]
  end

  module Content = struct
    external make
      :  ?asChild:bool
      -> ?forceMount:bool
      -> ?loop:bool
      -> ?onOpenAutoFocus:Types.focus_event
      -> ?onCloseAutoFocus:Types.focus_event
      -> ?onEscapeKeyDown:Types.keyboard_event
      -> ?onPointerDownOutside:Types.pointer_event
      -> ?onInteractOutside:Types.on_interact_outside_event
      -> ?className:string
      -> children:React.element
      -> React.element
      = "Content"
    [@@react.component] [@@mel.module "@radix-ui/react-dialog"]
  end

  module Close = struct
    external make
      :  ?asChild:bool
      -> ?className:string
      -> children:React.element
      -> React.element
      = "Close"
    [@@react.component] [@@mel.module "@radix-ui/react-dialog"]
  end

  module Title = struct
    external make
      :  ?asChild:bool
      -> ?className:string
      -> children:React.element
      -> React.element
      = "Title"
    [@@react.component] [@@mel.module "@radix-ui/react-dialog"]
  end

  module Description = struct
    external make
      :  ?asChild:bool
      -> ?className:string
      -> children:React.element
      -> React.element
      = "Description"
    [@@react.component] [@@mel.module "@radix-ui/react-dialog"]
  end
end

module Toast = struct
  module Provider = struct
    type swipeDirection =
      [ `right
      | `left
      | `up
      | `down
      ]

    external make
      :  ?duration:int
      -> ?label:int
      -> ?swipeDirection:bool
      -> ?swipeThreshold:swipeDirection
      -> children:React.element
      -> React.element
      = "Provider"
    [@@react.component] [@@mel.module "@radix-ui/react-toast"]
  end

  module Viewport = struct
    external make
      :  ?asChild:bool
      -> ?hotkey:string array
      -> ?label:string
      -> ?className:string
      -> React.element
      = "Viewport"
    [@@react.component] [@@mel.module "@radix-ui/react-toast"]
  end

  module Root = struct
    type type_ =
      [ `foreground
      | `backgro8und
      ]

    type data_state =
      [ `open_ [@mel.as "open"]
      | `closed
      ]

    type data_swipe =
      [ `start
      | `move
      | `cancel
      | `end_ [@mel.as "end"]
      ]

    type data_swipe_direction =
      [ `up
      | `down
      | `left
      | `right
      ]

    external make
      :  ?asChild:bool
      -> ?type_:type_
      -> ?duration:int
      -> ?defaultOpen:bool
      -> ?open_:(bool[@mel.as "open"])
      -> ?onOpenChange:((bool -> bool) -> unit)
      -> ?onEscapeKeyDown:Types.keyboard_event
      -> ?onPause:(unit -> unit)
      -> ?onResume:(unit -> unit)
      -> ?onSwipeStart:(React.Event.Synthetic.t -> unit)
      -> ?onSwipeMove:(React.Event.Synthetic.t -> unit)
      -> ?onSwipeEnd:(React.Event.Synthetic.t -> unit)
      -> ?onSwipeCancel:(React.Event.Synthetic.t -> unit)
      -> ?forceMount:bool
      -> ?className:string
      -> ?children:React.element
      -> ?dataState:(data_state[@mel.as "data-state"])
      -> ?dataSwipe:(data_swipe[@mel.as "data-swipe"])
      -> ?dataSwipeDirection:(data_swipe[@mel.as "data-swipe-direction"])
      -> React.element
      = "Root"
    [@@react.component] [@@mel.module "@radix-ui/react-toast"]
  end

  module Title = struct
    external make
      :  ?asChild:bool
      -> ?className:string
      -> ?children:React.element
      -> React.element
      = "Title"
    [@@react.component] [@@mel.module "@radix-ui/react-toast"]
  end

  module Description = struct
    external make
      :  ?asChild:bool
      -> ?className:string
      -> React.element
      = "Description"
    [@@react.component] [@@mel.module "@radix-ui/react-toast"]
  end

  module Action = struct
    external make : ?asChild:bool -> ?altText:string -> React.element = "Action"
    [@@react.component] [@@mel.module "@radix-ui/react-toast"]
  end

  module Close = struct
    external make
      :  ?asChild:bool
      -> ?className:string
      -> React.element
      = "Close"
    [@@react.component] [@@mel.module "@radix-ui/react-toast"]
  end
end

module Tooltip = struct
  module Provider = struct
    external make
      :  ?delayDuraion:int
      -> ?skipDelayDuraion:int
      -> ?disableHoverableContent:bool
      -> children:React.element
      -> React.element
      = "Provider"
    [@@react.component] [@@mel.module "@radix-ui/react-tooltip"]
  end

  module Root = struct
    external make
      :  ?open_:(bool[@mel.as "open"])
      -> ?defaultOpen:bool
      -> ?onOpenChange:((bool -> bool) -> unit)
      -> ?delayDuration:int
      -> ?disableHoverableContent:bool
      -> ?children:React.element
      -> React.element
      = "Root"
    [@@react.component] [@@mel.module "@radix-ui/react-tooltip"]
  end

  module Trigger = struct
    type data_state =
      [ `closed
      | `delayed_open
      | `instant_open
      ]

    external make
      :  asChild:bool
      -> ?className:string
      -> children:React.element
      -> ?dataState:(data_state[@mel.as "data-state"])
      -> React.element
      = "Trigger"
    [@@react.component] [@@mel.module "@radix-ui/react-tooltip"]
  end

  module Portal = struct
    external make
      :  ?forceMount:bool
      -> ?container:Dom.htmlElement
      -> children:React.element
      -> React.element
      = "Portal"
    [@@react.component] [@@mel.module "@radix-ui/react-tooltip"]
  end

  module Content = struct
    external make
      :  ?asChild:bool
      -> ?ariaLabel:(string[@mel.as "aria-label"])
      -> ?onEscapeKeyDown:Types.keyboard_event
      -> ?onPointerDownOutside:Types.pointer_event
      -> ?forceMount:bool
      -> ?side:Types.side
      -> ?sideOffset:int
      -> ?align:Types.align
      -> ?alignOffset:int
      -> ?avoidCollisions:bool
      -> ?collissionBoundary:Types.collision_boundary
      -> ?collissionPadding:Types.collision_padding
      -> ?arrowPadding:int
      -> ?sticky:Types.sticky
      -> ?hideWhenDetached:bool
      -> ?className:string
      -> children:React.element
      -> React.element
      = "Content"
    [@@react.component] [@@mel.module "@radix-ui/react-tooltip"]
  end

  module Arrow = struct
    external make
      :  ?asChild:bool
      -> ?width:int
      -> ?height:int
      -> ?className:string
      -> React.element
      = "Arrow"
    [@@react.component] [@@mel.module "@radix-ui/react-tooltip"]
  end
end
