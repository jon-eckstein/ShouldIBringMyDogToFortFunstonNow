
class WeatherEvaluator
  constructor : ->
     @weatherScore = ko.observable(0)
     @windScore = ko.observable(0)
     @precipScore = ko.observable(0)
     @tempScore = ko.observable(0)
     @tideScore = ko.observable(-999)
     @totalScore = ko.observable(0)
     @tempThreshold = 50
     @windThreshold = 20
     @chillThreshold = 50
     

  computeScore :  (@weather,@windSpeed,@windGusts,@temp,@windChill)  ->
     console.log @weather
     #look at the weather variable and see what it's doing...
     @weatherScore(@weatherScore() + -2) if @weather.indexOf('Rain') > -1
     @weatherScore(@weatherScore() + -1) if @weather.indexOf('Drizzle') > -1
     @weatherScore(@weatherScore() + -1) if @weather is 'Overcast'
     @weatherScore(@weatherScore() + -1) if @weather is 'Mostly Cloudy'
     @weatherScore(@weatherScore() + -2) if @weather.indexOf('Fog') > -1
     @weatherScore(@weatherScore() + -2) if @weather.indexOf('Showers') > -1
     
     @windScore(@windScore() + -1) if @windSpeed > @windThreshold
     @windScore(@windScore() + -1) if !isNaN(@windGusts) and @windGusts > @windThreshold

     @tempScore(@tempScore() + -1) if @temp < @tempThreshold
     @tempScore(@tempScore() + -1) if @windChill < @chillThreshold
    
     @totalScore(@weatherScore() + @windScore() + @tempScore())
     return @totalScore()

module.exports = WeatherEvaluator
