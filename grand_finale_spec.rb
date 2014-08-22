# grand final
# Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
# Be careful of the weather, it could be stormy!
# Check when all the planes have landed that they have the right status "landed"
# Once all the planes are in the air again, check that they have the status of flying!

require 'plane'
require 'airport'

describe "The grand finale (last spec)" do

def fill_the_air_with_planes
		the_air = []
		the_air << corsair = Plane.new
		the_air << tiger_moth = Plane.new
		the_air << concorde = Plane.new
		the_air << spad = Plane.new
		the_air << se_five_a = Plane.new
		the_air << spruce_goose = Plane.new
end

  it 'all planes can land and all planes can take off' do
		Weather::condition
		fill_the_air_with_planes
		airport = Airport.new
		the_air.each {|plane| airport.land(plane)}
		expect(airport.hanger.count).to eq 6
  end

end
