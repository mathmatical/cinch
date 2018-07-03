#!/usr/bin/ruby
require 'cinch'
require 'rubygems'
require 'weather-api'
require 'open_weather'
require 'forecast_io'
require './restaurant.rb'

require '/home/myoder/repos/cinch/.secrets/forecast_api.rb'
require './.secrets/openweather.rb'

  puts "this was 2 spaces"
  puts "this was a tab"

city_market = Restaurant.new("City Market", ["sushi"], "6",)
virgils = Restaurant.new("Virgil's Tacos", ["hispanic"], "4")
capital_club = Restaurant.new("Capital Club", "[german][american]", "8")
garland = Restaurant.new("Garland", "[indian][asian]", "6")
sosta = Restaurant.new("Sosta", "[cafe]", "4")
restaurant = [city_market, virgils, capital_club, garland, sosta]



bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.org"
    c.channels = ["#yoders-world"]
  end

  on :message, "hello" do |m|
    m.reply "Hello, #{m.user.nick}"
  end

  on :message, "weather" do |w|
  response = Weather.lookup_by_location('New York, NY', Weather::Units::CELSIUS)
    w.reply "#{w.user.nick}, the weather for today is:"
    sleep 1
    w.reply "#{response.title} #{response.condition.temp} degress Celsius; #{response.condition.text}"
  end

  on :message, "temp" do |t|
    options = { units: "metric", APPID: open_weather_api_key }
    response = OpenWeather::ForecastDaily.city_id("1273874", options)
    t.reply "#{t.user.nick}, the weather for today is:"
    #t.reply "response methods: #{t.methods.sort}"
    t.reply "#{response.methods} #{response.condition.temp} degress Celsius; #{response.condition.text}"
  end

  on :message, "forecast" do |f|
    response = ForecastIO.forecast(37.8267, -122.423)
    f.reply "Get ready..."
    (1..3).each do 
      sleep 1 
      f.reply "..."
    end
    response = response["currently"]
    f.reply "The attributes of your current weather experience: "
    response.each do |x|
      f.reply "#{x}"
      sleep 0.5
    end
  end

  on :message, "food" do |f|
    f.reply "Restaurants this week:"
    sleep 1
    restaurant.each do |x|
      f.reply "#{x.name}"
    end
  end
end

bot.start
