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

type onInteractOutsideEvent = [
  | #PointerDownOutside(ReactEvent.Pointer.t => unit)
  | #FocusOutside(ReactEvent.Focus.t => unit)
]
type onOpenAutoFocus = ReactEvent.Focus.t => unit
type onCloseAutoFocus = ReactEvent.Focus.t => unit
type onEscapeKeyDown = ReactEvent.Keyboard.t => unit
type onPointerDownOutside = ReactEvent.Pointer.t => unit
type onFocusOutside = ReactEvent.Focus.t => unit
