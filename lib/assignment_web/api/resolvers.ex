defmodule AssignmentWeb.Api.Resolvers do

  use Tesla, only: [:get], docs: false

  plug Tesla.Middleware.BaseUrl, "http://api.openweathermap.org"
  plug Tesla.Middleware.JSON

    def get_weather(_parent, %{latitude: latitude, longitude: longitude}, _res) do
      api_key = Application.get_env(:assignment, AssignmentWeb.Endpoint)[:api_key]
        case get("/data/2.5/onecall?lat=#{latitude}&lon=#{longitude}&units=metric&appid=#{api_key}") |> IO.inspect do
          {:ok, %env{body: body}} -> 
            daily = Enum.map(body["daily"], fn day -> 
              %{
                date: "#{DateTime.from_unix!(day["dt"])}",
                pressure: "#{day["pressure"]}",
                humidity: "#{day["humidity"]}",
                temperature: %{
                  day: "#{day["temp"]["day"]} C",
                  min: "#{day["temp"]["min"]} C",
                  max: "#{day["temp"]["max"]} C",
                  night: "#{day["temp"]["night"]} C",
                  evening: "#{day["temp"]["eve"]} C",
                  morning: "#{day["temp"]["morn"]} C"
                },
                feels_like: %{
                  day: "#{day["feels_like"]["day"]} C",
                  night: "#{day["feels_like"]["night"]} C",
                  evening: "#{day["feels_like"]["eve"]} C",
                  morning: "#{day["feels_like"]["morn"]} C"
                }
              }
            end)
            data = %{
                date: "#{DateTime.from_unix!(body["current"]["dt"])}",
                sunrise: "#{DateTime.from_unix!(body["current"]["sunrise"])}",
                sunset: "#{DateTime.from_unix!(body["current"]["sunset"])}",
                temperature: "#{body["current"]["temp"]} C",
                feels_like: "#{body["current"]["feels_like"]} C",
                weather: %{
                  main: "#{List.first(body["current"]["weather"])["main"]}",
                  description: "#{List.first(body["current"]["weather"])["description"]}",
                },
                daily: daily
              }
              {:ok, data}
            {:error, error} -> {:error, error}
        end
    end
end