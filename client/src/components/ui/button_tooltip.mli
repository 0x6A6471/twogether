val make
  :  label:string
  -> icon:string
  -> ?color:[ `gray | `red ]
  -> ?on_click:(unit -> unit)
  -> React.element
[@@react.component]
