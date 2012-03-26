
class TideEvaluator
	constructor : ->

	computeScore : (@rawTideData) ->
		console.log @rawTideData
		#find the next low tide...
		@nextLowTide=null
		for tide in @rawTideData.tideSummary
			if tide.data.type.indexOf("Max Ebb") > -1
				@nextLowTide = tide
				@tideString = "#{tide.data.type} at #{tide.utcdate.pretty}"
				break
		
		@nextLowTideDate = new Date "#{tide.utcdate.mon}/#{tide.utcdate.mday}/#{tide.utcdate.year} #{tide.utcdate.hour}:#{tide.utcdate.min}:00 UTC"
		console.log @nextLowTideDate
		@today = new Date
		console.log (@nextLowTideDate.getTime() - @today.getTime()) / 3600000


module.exports = TideEvaluator
