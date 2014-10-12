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


def check_breweries_for_missing_city

  cache = load_lat_lng( './geo/at-cities.csv' )

  i = 0
  Brewery.order(:id).each do |by|
    i += 1
    if by.city.nil?
      puts " city missing for entry #{i} »#{by.title}«"
    else
      latlng = cache[ by.city.title ]
      if latlng.nil?
        puts "latlng missing for city #{by.city.title} > #{by.city.region.title}"
      else
        print '.'
      end
    end
  end
end



class LatLng
  attr_reader :lat
  attr_reader :lng
  
  def initialize( lat, lng )
    @lat = lat
    @lng = lng
  end
end


def load_lat_lng( path )

  cache = {}

  File.open( path, 'r').each_line do |line|

    values = line.split(',')

    city_name        = values[2]
    city_lat         = values[6]
    city_lng         = values[7]
    
    if city_lat == '?' || city_lat.blank? ||
       city_lng == '?' || city_lng.blank? 
      ## skip missing lat/lng
    else
      cache[ city_name] = LatLng.new( city_lat.to_f, city_lng.to_f )  
    end
  end

  cache
end  # method load_lat_lng


def build_map()
  puts 'hello from build_map'

  cache = load_lat_lng( './geo/at-cities.csv' )
  ## dump for debugging
  pp cache

  entries = []

  i = 0
  Brewery.order(:id).each do |by|
    i += 1
    ## pp by
    puts " #{i} »#{by.title}«"

    if by.city.nil?
      puts " *** city is nil !!!!!"
    else
      puts "       #{by.city.title} > #{by.city.region.title}"

      latlng = cache[ by.city.title ]
      if latlng.nil?
        puts "         *** latlng is nil for "
      else
        puts "         lat: #{latlng.lat} lng: #{latlng.lng}"
        entries << gen_geojson( by, latlng )
      end
    end
  end

  hash = {
    'type' => 'FeatureCollection',
    'features' => entries
  }

  ### write to ./build/at.geojson

  File.open( './build/at.geojson', 'w' ) do |file|
    file.write JSON.pretty_generate( hash )
  end

end # method build_map



def gen_geojson( brewery, latlng )
  hash = {
    'type' => 'Feature',
    'geometry' => {
        'type' => 'Point',
        'coordinates' => [ latlng.lat, latlng.lng ]
    },
    'properties' => {
        'Name' => brewery.title,
        'City' => brewery.city.title,
        ## 'Province': brewery.city.region.title,
        'Address' => brewery.address,
        ## 'Web' => brewery.web, 
        'Type' => 'Brewery',
        'marker-color' => '#ff0000'   ## red
    }
  }

  hash
end



