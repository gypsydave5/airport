require 'weather'

class Airport

	attr_reader :hanger

	include Weather

	def initialize(capacity: 200, name: "This")
		@capacity = capacity
		@hanger = []
	end

	def land plane
		p Weather::conditions
		do_not_land("we're full") if full?
		do_not_land("the weather's bad") if Weather::conditions == "stormy"
		do_not_land("you're already here!") if @hanger.include?(plane)
		@hanger << plane
	end

	def take_off plane
		raise StandardError, "the weather's bad" if Weather::conditions == "stormy"
		raise ArgumentError, "This plane is not currently at the Airport" unless @hanger.include?(plane)
		@hanger.delete(plane)
	end

	def full?
		@hanger.count == @capacity
	end

	def to_s
		@name
	end

	def do_not_land(reason)
		raise(ArgumentError, reason) if reason == "you're already here!"
		raise StandardError, reason
	end

end
