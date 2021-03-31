defmodule AssignmentWeb.Api.Types do
    use Absinthe.Schema.Notation

    object :weatherType do
        field :main, :string
        field :description, :string
    end

    object :temperatureType do
        field :day, :string
        field :min, :string
        field :max, :string
        field :night, :string
        field :evening, :string
        field :morning, :string
    end

    object :feelsLikeType do
        field :day, :string
        field :night, :string
        field :evening, :string
        field :morning, :string
    end

    object :dailyType do
        field :date, :string
        field :pressure, :string
        field :humidity, :string
        field :temperature, :temperatureType
        field :feelsLike, :feelsLikeType
    end
    
    object :weatherForecastType do
        field :date, :string
        field :sunrise, :string
        field :sunset, :string
        field :temperature, :string
        field :feelsLike, :string
        field :weather, :weatherType
        field :daily, list_of(:dailyType)
    end

end