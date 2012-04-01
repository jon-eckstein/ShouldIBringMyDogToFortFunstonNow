
class TideEvaluator
	constructor : ->
		@totalScore = ko.observable(0)


	computeScore : (@rawTideData) ->
		console.log @rawTideData
		#find the next low tide...
		@nextLowTide=null
		for tide in @rawTideData.tideSummary
			if tide.data.type.indexOf("Max Ebb") > -1
				@nextLowTide = tide
				@tideString = "#{tide.data.type} at #{tide.utcdate.pretty}"
				break

		if @nextLowTide?
		   @nextLowTideDate = new Date "#{@nextLowTide.utcdate.mon}/#{@nextLowTide.utcdate.mday}/#{@nextLowTide.utcdate.year} #{@nextLowTide.utcdate.hour}:#{@nextLowTide.utcdate.min}:00 UTC"
		   console.log @nextLowTideDate
		   @today = new Date
		   @nextLowTideHours = (@nextLowTideDate.getTime() - @today.getTime()) / 3600000
		   @totalScore(-2) if @nextLowTideHours > 18
		   @totalScore(-1) if @nextLowTideHours > 10
		   return @totalScore()

module.exports = TideEvaluator
