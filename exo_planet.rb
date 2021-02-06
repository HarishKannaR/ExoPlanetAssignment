require 'csv'
require 'json'
require 'byebug'
class ExoPlanet
  def orphan_planets
    exo_planet = set_exo_planet
    value = exo_planet.inject(0) do |sum, value|
      sum += 1 if value["TypeFlag"] == 3
      sum
    end
    return "Number of Orphan planets is: #{value}"
  end

  def get_nearest_planet_to_sun
    exo_planet = set_exo_planet.select{|x| x unless [nil, ""].include?(x["DistFromSunParsec"]) }
    exo_planet = exo_planet.sort_by{|x| x["DistFromSunParsec"]}
    nearest_planet = exo_planet.first["PlanetIdentifier"]
    return "Nearest planet orbiting around the hottest star is: #{nearest_planet}"
  end

  def get_planet_timeline(year)
    values = group_by_year
    # puts "Enter the year to find the planet groups:"
    # year = gets.chomp.to_i
    result = values[year]
    unless result.nil?
      return "In the year #{year}, we discovered #{result[:small]} small planets, #{result[:medium]} medium planets and #{result[:large]} large planets"
    else
      return "No records found for the year #{year}"
    end
  end

  def result
    self.orphan_planets
    self.get_nearest_planet_to_sun
    self.get_planet_timeline
  end

  private

  def set_exo_planet
    exo_planet = import_planet_details
    JSON.parse(exo_planet)
  end

  def import_planet_details
    file = File.read('oec.csv')
    csv = CSV.parse(file, headers: true)
    exo_planet = csv.map(&:to_h).to_json
    return exo_planet
  end

  def group_by_year
    exo_planet = set_exo_planet
    yearly_values = exo_planet.sort_by{|x| x["DiscoveryYear"].to_s }.group_by{|x| x["DiscoveryYear"]}
    # puts "Total exo_planet records: #{exo_planet.count}"
    # puts "Post grouping: #{yearly_values.count}"
    values = {}
    yearly_values.each do |year, records|
      unless year.nil?
        # puts "Year: #{year}, total records: #{records.count}"
        result = {small: 0, medium: 0, large: 0}
        records = records.map{|x| x["RadiusJpt"] }.compact
        records.each do |record|
          result[:small] += 1 if record.to_f <= 1
          result[:medium] += 1 if record.to_f > 1 && record.to_f <= 2
          result[:large] += 1 if record.to_f > 2
        end
        # puts result
        values[year.to_i] = result
      end
    end
    return values
  end
end

# ExoPlanet.new.orphan_planets
# ExoPlanet.new.get_nearest_planet_to_sun
# ExoPlanet.new.get_planet_timeline

