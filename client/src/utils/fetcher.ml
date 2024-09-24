external api_url : string = "import.meta.env.VITE_API_URL"

let headers =
  let dict = Js.Dict.empty () in
  Js.Dict.set dict "Content-Type" "application/json";
  Fetch.HeadersInit.makeWithDict dict
;;

let fetch url_path ~decoder =
  Js.Promise.(
    Fetch.fetchWithInit
      (api_url ^ url_path)
      (Fetch.RequestInit.make () ~credentials:Include ~headers)
    |> then_ Fetch.Response.json
    |> then_ (fun json -> decoder json |> resolve))
;;
