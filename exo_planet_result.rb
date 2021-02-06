require './exo_planet.rb'

orphan_planets = ExoPlanet.new.orphan_planets
puts orphan_planets


nearest_planet = ExoPlanet.new.get_nearest_planet_to_sun
puts nearest_planet

puts "Enter year to find the total number of planets discovered based on groups:"
year = gets.chomp.to_i

result = ExoPlanet.new.get_planet_timeline(year)
puts result
