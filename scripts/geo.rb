# encoding: utf-8

# geojson map generator scripts

puts 'hello from geo'



### model shortcuts

Continent = WorldDb::Model::Continent
Country   = WorldDb::Model::Country
City      = WorldDb::Model::City

Brewery   = BeerDb::Model::Brewery
Brand     = BeerDb::Model::Brand
Beer      = BeerDb::Model::Beer


def build_map()
  puts 'hello from build_map'

  i = 0
  Brewery.order(:id).each do |by|
    i += 1
    ## pp by
    puts " #{i} »#{by.title}«"

    if by.city.nil?
      puts " *** city is nil !!!!!"
    else
      puts "       #{by.city.title} > #{by.city.region.title}"
    end
  end

end

