require 'airport'

# A plane currently in the airport can be requested to take off.
#
# No more planes can be added to the airport, if it's full.
# It is up to you how many planes can land in the airport and how that is impermented.
#
# If the airport is full then no planes can land
describe Airport do
  let(:airport) { Airport.new }
	let(:plane) { double :plane }

			def sunny_weather
				allow(Weather).to receive(:conditions).and_return("sunny")
			end

			def stormy_weather
				allow(Weather).to receive(:conditions).and_return("stormy")
			end

  context 'taking off and landing' do

    it 'a plane can land' do
			sunny_weather
			expect(airport.land(plane)).to eq airport.hanger
    end

		it 'a plane cannnot land if it is already at the airport' do
			sunny_weather
			airport.land(plane)
			expect{airport.land(plane)}.to raise_error(ArgumentError, "you're already here!")
		end

    it 'a plane can take off' do
			sunny_weather
			airport.land(plane)
			expect(airport.take_off(plane)).to eq plane
    end

		it 'a place cannot take off if it is not at the airport' do
			sunny_weather
			expect{airport.take_off(plane)}.to raise_error(ArgumentError, "This plane is not currently at the Airport")
		end
  end

  context 'traffic control' do

		def full_airport
			capacity_two_airport = Airport.new(capacity: 2)
			sopwith_camel = double :sopwith_camel
			se_five_a = double :se_five_a
			capacity_two_airport.land(sopwith_camel)
			capacity_two_airport.land(se_five_a)
			return capacity_two_airport
		end

		it 'knows when the airport is full' do
			sunny_weather
			airport = full_airport
			expect(airport.full?).to be true
		end

    it 'a plane cannot land if the airport is full' do
			sunny_weather
			airport = full_airport
			expect{airport.land(plane)}.to raise_error(StandardError, "we're full")
		end

    # Include a weather condition using a module.
    # The weather must be random and only have two states "sunny" or "stormy".
    # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.
    #
    # This will require stubbing to stop the random return of the weather.
    # If the airport has a weather condition of stormy,
    # the plane can not land, and must not be in the airport

    context 'weather conditions' do
			def stormy_weather
				allow(Weather).to receive(:conditions).and_return("stormy")
			end

      it 'a plane cannot take off when there is a storm brewing' do
				stormy_weather
				expect{airport.land(plane)}.to raise_error(StandardError, "the weather's bad")
      end

      it 'a plane cannot land in the middle of a storm' do
				stormy_weather
				expect{airport.take_off(plane)}.to raise_error(StandardError, "the weather's bad")
      end
    end
  end
end

# When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
#
# When we land a plane at the airport, the plane in question should have its status changed to "landed"
#
# When the plane takes of from the airport, the plane's status should become "flying"
