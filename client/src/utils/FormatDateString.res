let monthNames = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
]

let formatDateString = (dateString: string): string => {
  let dateObj = RescriptCore.Date.fromString(dateString)
  let month = RescriptCore.Date.getMonth(dateObj)
  let monthName = switch monthNames[month] {
  | Some(name) => name
  | None => "Invalid Date"
  }

  let day = RescriptCore.Int.toString(RescriptCore.Date.getDate(dateObj))
  let year = RescriptCore.Int.toString(RescriptCore.Date.getFullYear(dateObj))

  `${monthName} ${day}, ${year}`
}
