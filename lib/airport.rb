require 'weather'

class Airport

	attr_accessor :hanger, :capacity

	include Weather

	def initialize capacity: 200, name: "the airport"
		@capacity = capacity
		@hanger = []
		@name = name
	end

	def land plane
		landing_safety_check_for plane
		plane.land
		@hanger << plane
	end

	def take_off plane
		take_off_safety_check_for plane
		plane.take_off
		@hanger.delete(plane)
	end

	def full?
		@hanger.count == @capacity
	end

	def to_s
		@name
	end

	def landing_safety_check_for plane
		raise Weather::Warning if Weather::stormy?
		raise Airport::Full, "#{self} is full" if full?
		raise Airport::PlaneMissing, "#{plane} not flying!" if plane.landed?
	end

	def take_off_safety_check_for plane
		raise Weather::Warning if Weather::stormy?
		raise Airport::PlaneMissing, "That plane is not currently at #{self}" unless @hanger.include?(plane)
	end

	class Full < StandardError
	end

	class PlaneMissing < StandardError
	end

end
