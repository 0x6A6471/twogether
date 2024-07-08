@react.component
let make = () => {
  <div className="flex flex-col items-center justify-center h-screen">
    <h1 className="text-4xl font-bold text-gray-800"> {"404"->React.string} </h1>
    <p className="text-gray-600"> {"Page not found"->React.string} </p>
  </div>
}
