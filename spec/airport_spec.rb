require 'airport'
require 'weather_spec'

describe Airport do
  let(:airport) { Airport.new }
	let(:plane) { double :plane, land: nil, take_off: nil, landed?: false}
	let(:landed_plane) { double :plane, land: nil, take_off: nil, landed?: true}

	it_behaves_like 'a weather forecast'

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

		it 'a plane cannnot land if it is already landed' do
			sunny_weather
			expect{airport.land(landed_plane)}.to raise_error(Airport::PlaneMissing, "#{landed_plane} not flying!")
		end

		it 'sets the status of the plane to landed when it lands' do
			sunny_weather
			expect(plane).to receive(:land)
			airport.land(plane)
		end

    it 'a plane can take off' do
			sunny_weather
			airport.land(plane)
			expect(airport.take_off(plane)).to eq plane
    end

		it 'a plane cannot take off if it is not at the airport' do
			sunny_weather
			expect{airport.take_off(plane)}.to raise_error(Airport::PlaneMissing, "That plane is not currently at the airport")
		end

		it 'sets the status of the plane to flying when it takes-off' do
			sunny_weather
			airport.land(plane)
			expect(plane).to receive(:take_off)
			airport.take_off(plane)
		end

  end

  context 'traffic control' do

		def full_airport
			airport = Airport.new(capacity: 2)
			airport.capacity.times {airport.land(plane)}
			return airport
		end

		it 'knows when the airport is full' do
			sunny_weather
			airport = full_airport
			expect(airport.full?).to be true
		end

    it 'a plane cannot land if the airport is full' do
			sunny_weather
			airport = full_airport
			expect{airport.land(plane)}.to raise_error(Airport::Full, "the airport is full")
		end

    context 'weather conditions' do

      it 'a plane cannot take off when there is a storm brewing' do
				stormy_weather
				expect{airport.land(plane)}.to raise_error(Weather::Warning)
      end

      it 'a plane cannot land in the middle of a storm' do
				stormy_weather
				expect{airport.take_off(plane)}.to raise_error(Weather::Warning)
      end

    end
  end
end
