WeatherEvaluator = require("models/WeatherEvaluator")

module.exports = App =
  init :->
    @weatherText = ko.observable('...')
    @windText = ko.observable('...')
    @tempText = ko.observable('...')
    @obsTimeText = ko.observable('')
    @evaler = new WeatherEvaluator
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
         @tempText currentObs.temp_f + "F (feels like " + currentObs.windchill_f + "F with wind chill)"
         @weatherText currentObs.weather
         @windText currentObs.wind_mph + " MPH gusting to " + currentObs.wind_gust_mph + " MPH"
         @obsTimeText currentObs.observation_time
         @evaler.computeScore(currentObs.weather,currentObs.wind_mph, parseFloat(currentObs.wind_gust_mph), currentObs.temp_f ,parseFloat(currentObs.windchill_f))
