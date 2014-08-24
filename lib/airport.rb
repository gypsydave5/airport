require 'weather'

class Airport

	attr_accessor :hanger

	include Weather

	def initialize capacity: 200, name: "the airport"
		@capacity = capacity
		@hanger = []
		@name = name
	end

	def land plane
		landing_safety_checks_for plane
		plane.land
		@hanger << plane
	end

	def take_off plane
		take_off_safety_checks_for plane
		plane.take_off
		@hanger.delete(plane)
	end

	def full?
		@hanger.count == @capacity
	end

	def to_s
		@name
	end

	def do_not_land_because reason
		raise StandardError, reason
	end

	def landing_safety_checks_for plane
		raise Weather::Warning if Weather::stormy?
		raise StandardError, "#{self} is full" if full?
		raise StandardError, "you're not even flying!" if plane.landed?
	end

	def take_off_safety_checks_for plane
		raise Weather::Warning if Weather::stormy?
		raise ArgumentError, "That plane is not currently at #{self}" unless @hanger.include?(plane)
	end

end
