type interactOutsideEvent = [
  | #PointerDownOutside(ReactEvent.Pointer.t)
  | #FocusOutside(ReactEvent.Focus.t)
]

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
