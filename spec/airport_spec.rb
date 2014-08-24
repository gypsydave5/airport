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
			expect{airport.land(landed_plane)}.to raise_error(StandardError, "you're not even flying!")
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
			expect{airport.take_off(plane)}.to raise_error(ArgumentError, "That plane is not currently at the airport")
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
			capacity_two_airport = Airport.new(capacity: 2)
			sopwith_camel = double :sopwith_camel, landed?: true
			se_five_a = double :se_five_a, landed?: true
			capacity_two_airport.hanger << sopwith_camel
			capacity_two_airport.hanger << se_five_a
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
			expect{airport.land(plane)}.to raise_error(StandardError, "the airport is full")
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
