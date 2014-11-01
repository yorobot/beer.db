# encoding: utf-8

# cities list generator scripts   - used for geocoding (address to lat/lng coords)

puts 'hello from cities'


require './scripts/models'


################
## fix/todo:
##    make generic / do NOT hardcode de/bayern etc.

def save_cities_for_breweries_for_country( country_code )

  cty  = Country.find_by_key!( country_code )

  breweries = cty.breweries

  puts "breweries: #{breweries.count}"

  states = {}

  i = 0
  breweries.each do |by|
    i += 1
    if by.city.nil?
      puts " **** city missing for entry #{i} »#{by.title}« addr: »#{by.address}«"
    else
      puts "      #{i} »#{by.city.title}« addr: »#{by.address}« cty: »#{by.country.title}«"

      state_name = by.region.title
      state_name = state_name.sub(/\[[^\]]+\]/, '').strip  ### remove optional translation []

      cities = states[state_name] || []

      cities << by.city.title

      states[state_name] = cities
    end
  end


  # remove duplicate (cities)
  states.each do|k,v|
    v.uniq!  
  end

  pp states

  File.open( "./geo/#{country_code}-cities-input.txt", 'w' ) do |file|
    states.each do |k,cities|
      file.puts "- #{k}"
      file.puts ''
      cities.each do |city|
        file.puts city
      end
    end
  end

end

