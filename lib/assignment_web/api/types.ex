defmodule AssignmentWeb.Api.Types do
    use Absinthe.Schema.Notation

    object :weather_type do
        field :main, :string
        field :description, :string
    end

    object :temperature_type do
        field :day, :string
        field :min, :string
        field :max, :string
        field :night, :string
        field :evening, :string
        field :morning, :string
    end

    object :feels_like_type do
        field :day, :string
        field :night, :string
        field :evening, :string
        field :morning, :string
    end

    object :daily_type do
        field :date, :string
        field :pressure, :string
        field :humidity, :string
        field :temperature, :temperature_type
        field :feels_like, :feels_like_type
    end
    
    object :weather_forecast_type do
        field :date, :string
        field :sunrise, :string
        field :sunset, :string
        field :temperature, :string
        field :feels_like, :string
        field :weather, :weather_type
        field :daily, list_of(:daily_type)
    end

end