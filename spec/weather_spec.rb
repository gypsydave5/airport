require 'weather'

shared_examples 'a weather forecast' do

	it 'can tell you the weather conditions' do
		expect(Weather::conditions).not_to be nil
	end

	it 'can raise Weather Warning exceptions' do
		expect{raise Weather::Warning}.to raise_error Weather::Warning
	end

end
