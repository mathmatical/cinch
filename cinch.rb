require 'cinch'
require 'rubygems'
require 'weather-api'
require 'open_weather'
require 'forecast_io'

class Restaurant
	attr_accessor :name
	attr_accessor :type
	attr_accessor :seating
	attr_accessor :rating
	attr_accessor :visited
  def initialize (name, style=[], seating_max=0, rating=0, visited=[])  
	  @name = name
		@type = style
		@seating = seating
		@rating = rating
		@visited = visited
	end
end

city_market = Restaurant.new("City Market", ["sushi"], "6",)
virgils = Restaurant.new("Virgil's Tacos", ["hispanic"], "4")
capital_club = Restaurant.new("Capital Club", "[german][american]", "8")
garland = Restaurant.new("Garland", "[indian][asian]", "6")
sosta = Restaurant.new("Sosta", "[cafe]", "4")
restaurant = [city_market, virgils, capital_club, garland, sosta]


ForecastIO.api_key = "216232cc674a79fb3f4c5afefd5ead8f"

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

	on :message, "temps" do |t|
		response = OpenWeather::ForecastDaily.city_id("1273874")
		t.reply "#{t.user.nick}, the weather for today is:"
		t.reply "response methods: #{t.methods.sort}"
#		t.reply "#{response.methods} #{response.condition.temp} degress Celsius; #{response.condition.text}"
	end

	on :message, "forecast" do |f|
		response = ForecastIO.forecast(37.8267, -122.423)
		f.reply "Get ready..."
		sleep 1
		f.reply "...."
		sleep 1
		f.reply "...."
		sleep 1
		butts = response["currently"]
		f.reply "The attributes of your current weather experience: "
		butts.each do |x|
			f.reply "#{x}"
			sleep 1
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
