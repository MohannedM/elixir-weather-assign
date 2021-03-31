defmodule AssignmentWeb.Api.Resolvers do

  use Tesla, only: [:get], docs: false

  plug Tesla.Middleware.BaseUrl, "http://api.openweathermap.org"
  plug Tesla.Middleware.JSON

    def get_weather(_parent, %{latitude: latitude, longitude: longitude}, _res) do
        case get("/data/2.5/onecall?lat=#{latitude}&lon=#{longitude}&appid=aca64a2b2f45ecd13b1e5cfd89bd7f64") do
          {:ok, %env{body: body}} -> 
            daily = Enum.map(body["daily"], fn day -> 
              %{
                date: "#{DateTime.from_unix!(day["dt"])}",
                pressure: "#{day["pressure"]}",
                humidity: "#{day["humidity"]}",
                temperature: %{
                  day: "#{day["temp"]["day"] - 273.15} C",
                  min: "#{day["temp"]["min"] - 273.15} C",
                  max: "#{day["temp"]["max"] - 273.15} C",
                  night: "#{day["temp"]["night"] - 273.15} C",
                  evening: "#{day["temp"]["eve"] - 273.15} C",
                  morning: "#{day["temp"]["morn"] - 273.15} C"
                },
                feelsLike: %{
                  day: "#{day["feels_like"]["day"] - 273.15} C",
                  night: "#{day["feels_like"]["night"] - 273.15} C",
                  evening: "#{day["feels_like"]["eve"] - 273.15} C",
                  morning: "#{day["feels_like"]["morn"] - 273.15} C"
                }
              }
            end)
            data = %{
                date: "#{DateTime.from_unix!(body["current"]["dt"])}",
                sunrise: "#{DateTime.from_unix!(body["current"]["sunrise"])}",
                sunset: "#{DateTime.from_unix!(body["current"]["sunset"])}",
                temperature: "#{body["current"]["temp"] - 273.15} C",
                feelsLike: "#{body["current"]["feels_like"] - 273.15} C",
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