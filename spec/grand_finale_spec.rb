require 'airport'
require 'plane'

describe "The grand finale (last spec)" do

	def sunny_weather
		allow(Weather).to receive(:conditions).and_return("sunny")
	end

	it 'all planes can land and all planes can take off' do
		sunny_weather
		planes = []
		planes << corsair = Plane.new
		planes << thunderbird_one = Plane.new
		planes << concorde = Plane.new
		planes << jimbo = Plane.new
		planes << spruce_goose = Plane.new
		planes << tiger_moth = Plane.new

		airport = Airport.new

		planes.each {|plane| airport.land(plane)}
		expect(airport.hanger).to eq planes
		expect(planes.all?(&:landed?)).to be true
		planes.each {|plane| airport.take_off(plane)}
		expect(planes.all?(&:flying?)).to be true
	end

end
