class Airport

	def initialize(capacity: 200)
		@capacity = capacity
		@hanger = []
	end

	def land plane
		@hanger << plane
		nil
	end

	def take_off plane
		@hanger.delete(plane)
	end

	def full?
		@hanger.count == @capacity
	end

end
