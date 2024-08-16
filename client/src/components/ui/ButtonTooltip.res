type color = [#gray | #red]

@react.component
let make = (~label: string, ~icon: string, ~color: color=#gray, ~onClick: unit => unit) => {
  let hoverStyles = switch color {
  | #gray => "hover: bg-gray-50 hover:text-gray-700"
  | #red => "hover:bg-rose-50 hover:text-rose-700"
  }

  <Radix.Tooltip.Provider>
    <Radix.Tooltip.Root delayDuration={200}>
      <Radix.Tooltip.Trigger asChild={true}>
        <button
          onClick={_ => onClick()}
          className={`${hoverStyles} hidden rounded-md bg-white p-1.5 text-sm hover:bg-gray-50 hover:text-gray-700 sm:block`}>
          <Icon name=icon />
        </button>
      </Radix.Tooltip.Trigger>
      <Radix.Tooltip.Portal>
        <Radix.Tooltip.Content
          className="select-none rounded bg-black text-white p-2 leading-none shadow text-xs"
          sideOffset={4}>
          {React.string(label)}
        </Radix.Tooltip.Content>
      </Radix.Tooltip.Portal>
    </Radix.Tooltip.Root>
  </Radix.Tooltip.Provider>
}
