defmodule AssignmentWeb.Api.Schmea do
    use Absinthe.Schema

    import_types AssignmentWeb.Api.Types

    alias AssignmentWeb.Api.Resolvers


    query do
        field :weatherforecast, :weatherForecastType do
            arg :latitude, :float
            arg :longitude, :float
            resolve &Resolvers.get_weather/3
        end
    end
end