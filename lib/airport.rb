require 'weather'

class Airport

	include Weather

	def initialize(capacity: 200, name: "This")
		@capacity = capacity
		@hanger = []
	end

	def land plane
		raise StandardError, "Airport is full - please do not land!" if full?
		raise StandardError, "Weather conditions at Airport unsuitable for landing." if Weather::conditions == "stormy"
		@hanger << plane
		nil
	end

	def take_off plane
		raise StandardError, "Weather conditions at Airport unsuitable for take-off." if Weather::conditions == "stormy"
		@hanger.delete(plane)
	end

	def full?
		@hanger.count == @capacity
	end

	def to_s
		@name
	end

end
