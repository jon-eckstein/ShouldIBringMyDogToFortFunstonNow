WeatherEvaluator = require("models/WeatherEvaluator")
TideEvaluator = require("models/TideEvaluator")

module.exports = App =
  init :->
    @weatherText = ko.observable('...')
    @windText = ko.observable('...')
    @tempText = ko.observable('...')
    @tideText = ko.observable('No tide data available.')
    @obsTimeText = ko.observable('')
    @weatherEvaler = new WeatherEvaluator
    @tideEvaler = new TideEvaluator
    @isError = ko.observable(false)
    @isRequestComplete = ko.observable(false)

  getWeatherData: ->
    $.ajax 'http://api.wunderground.com/api/f88d918861288deb/conditions/tide/q/pws:KCASANFR69.json',
     type: 'GET'
     dataType: 'jsonp'
     timeout: 6000

     complete: => @isRequestComplete(true)

     error: (jqXHR, textStatus, errorThrown) => @isError(true)

     success: (data, textStatus, jqXHR) =>
         currentObs = data.current_observation
         console.log currentObs
         displayTempText = currentObs.temp_f + "F"
         displayTempText += "(feels like " + currentObs.windchill_f + "F with wind chill)" if !isNaN(currentObs.windchill_f)
         @tempText displayTempText
         @weatherText currentObs.weather
         @windText currentObs.wind_mph + " MPH gusting to " + currentObs.wind_gust_mph + " MPH"
         @obsTimeText currentObs.observation_time
         @weatherEvaler.computeScore(currentObs.weather,currentObs.wind_mph, parseFloat(currentObs.wind_gust_mph), currentObs.temp_f ,parseFloat(currentObs.windchill_f))
         if data.tide.tideSummary.length > 0
            @tideEvaler.computeScore(data.tide)
            @tideText  "Next low tide in #{@tideEvaler.nextLowTideHours.toFixed(2)} hours"
         #console.log @tideEvaler.nextLowTideHours
