defmodule AssignmentWeb.Api.Schmea do
    use Absinthe.Schema

    import_types AssignmentWeb.Api.Types

    alias AssignmentWeb.Api.Resolvers


    query do
        field :weatherforecast, :weather_forecast_type do
            arg :latitude, non_null(:string)
            arg :longitude, non_null(:string)
            resolve &Resolvers.get_weather/3
        end
    end
end