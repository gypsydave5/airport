require 'plane'

# When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
#
# When we land a plane at the airport, the plane in question should have its status changed to "landed"
#
# When the plane takes of from the airport, the plane's status should become "flying"
describe Plane do

	it_behaves_like 'a weather forecast'

  let(:plane) { Plane.new }

  it 'has a flying status when created' do
		expect(plane.status).to eq :flying
  end

  it 'can take off' do
		expect(plane.take_off).to be plane
  end

  it 'changes its status to flying after taking off' do
		expect(plane.flying?).to be true
  end

  it 'can land' do
		expect(plane.land).to be plane
  end

  it 'changes its status to landed after landing' do
		plane.land
		expect(plane.landed?).to be true
  end

end
