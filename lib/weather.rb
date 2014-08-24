module Weather
	def self.conditions
		["sunny", "stormy"].sample
	end

	def self.stormy?
		self.conditions == "stormy"
	end

	class Warning < StandardError

		def to_s
			"Weather unsuitable"
		end

	end

end
