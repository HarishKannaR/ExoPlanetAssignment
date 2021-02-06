require 'rspec/autorun'
require './exo_planet.rb'

describe 'ExoPlanet' do
  subject { ExoPlanet.new }
    it 'finds the count of orphan planets' do
      result = subject.orphan_planets
      expect(result).to eq("Number of Orphan planets is: 0")
    end

  it 'finds and prints the closest planet orbitting the hottest star' do
    result = subject.get_nearest_planet_to_sun
    expect(result).to eq("Nearest planet orbiting around the hottest star is: Proxima Centauri b")
  end

  context "finds total number of small medium and large planets discovered for specific year" do
    it 'returns the total count for year 2004' do
      result = subject.get_planet_timeline(2004)
      expect(result).to eq("In the year 2004, we discovered 2 small planets, 5 medium planets and 0 large planets")
    end

    it 'returns nil for the year 200' do
      result = subject.get_planet_timeline(200)
      expect(result).to eq("No records found for the year 200")
    end
  end

  context "test private methods of the class" do
    it "#set_exo_planet" do
      result = subject.send(:set_exo_planet)
      expect(result.count).to eq(3584)
      expect(result.class).to eq(Array)
    end

    it "#import_planet_details" do
      result = subject.send(:import_planet_details)
      expect(result.class).to eq(String)
    end

    it "#group_by_year" do
      result = subject.send(:group_by_year)
      expect(result.class).to eq(Hash)
    end
  end
end
