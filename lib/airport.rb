require 'weather'

class Airport

	attr_reader :hanger

	include Weather

	def initialize(capacity: 200, name: "This")
		@capacity = capacity
		@hanger = []
	end

	def land plane
		raise StandardError, "Airport is full - please do not land!" if full?
		raise StandardError, "Weather conditions at Airport unsuitable for landing." if Weather::conditions == "stormy"
		raise ArgumentError, "This plane has already landed!" if @hanger.include?(plane)
		@hanger << plane
	end

	def take_off plane
		raise StandardError, "Weather conditions at Airport unsuitable for take-off." if Weather::conditions == "stormy"
		raise ArgumentError, "This plane is not currently at the Airport" unless @hanger.include?(plane)
		@hanger.delete(plane)
	end

	def full?
		@hanger.count == @capacity
	end

	def to_s
		@name
	end

end
