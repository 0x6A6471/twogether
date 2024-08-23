@react.component
let make = () =>
  <div className="flex items-center justify-center h-full">
    <div
      className="bg-white border border-gray-100 space-y-8 flex flex-col max-w-md mx-auto items-center justify-center p-8 rounded-2xl">
      <div className="text-center">
        <p> {React.string("You do not have any guests yet.")} </p>
        <p> {React.string("Click the button below to add a new guest.")} </p>
      </div>
      <Guests.GuestDialog triggerText="Add Guest" triggerClassName="w-full justify-center" />
    </div>
  </div>
