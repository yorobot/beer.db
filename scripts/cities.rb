# encoding: utf-8

# cities list generator scripts   - used for geocoding (address to lat/lng coords)

puts 'hello from cities'



### model shortcuts

Continent = WorldDb::Model::Continent
Country   = WorldDb::Model::Country
Region    = WorldDb::Model::Region
City      = WorldDb::Model::City

Brewery   = BeerDb::Model::Brewery
Brand     = BeerDb::Model::Brand
Beer      = BeerDb::Model::Beer


################
## fix/todo:
##    make generic / do NOT hardcode de/bayern etc.

def check_breweries

  puts "breweries: #{Brewery.count}"

  cities = []

  i = 0
  Brewery.order(:id).each do |by|
    i += 1
    if by.city.nil?
      puts " **** city missing for entry #{i} »#{by.title}« addr: »#{by.address}«"
    else
      puts "      #{i} »#{by.city.title}« addr: »#{by.address}« cty: »#{by.country.title}«"
      cities << by.city.title
    end
  end
  
  cities = cities.uniq   # remove duplicates
  pp cities
  
  
  File.open( './geo/de-cities-input.txt', 'w' ) do |file|
    file.puts "- Bayern"
    file.puts ''
    cities.each do |city|
      file.puts city
    end
  end

end

