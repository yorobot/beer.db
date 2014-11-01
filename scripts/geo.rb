# encoding: utf-8

# geojson map generator scripts

puts 'hello from geo'


require './scripts/models'  ### model shortcuts


def check_breweries_for_missing_city( breweries, cache )

  i = 0
  breweries.each do |by|
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



def build_map_for( breweries, path, cache )

  entries = []

  i = 0
  breweries.each do |by|
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

  File.open( path, 'w' ) do |file|
    file.write JSON.pretty_generate( hash )
  end

end


def build_map_de
  puts 'hello from build_map_de'

  de  = Country.find_by_key!( 'de' )

  by  = Region.find_by_key_and_country_id!( 'by',  de.id )

  breweries_by = by.breweries

  cache = load_lat_lng( './geo/de-cities.csv' )   
  ## dump for debugging
  pp cache

  build_map_for( breweries_by, './build/by.geojson', cache )

  ###
  check_breweries_for_missing_city( breweries_by, cache )

end  # method build_map_de


def build_map_at
  puts 'hello from build_map_at'

  at  = Country.find_by_key!( 'at' )

  n  = Region.find_by_key_and_country_id!( 'n',  at.id )
  o  = Region.find_by_key_and_country_id!( 'o',  at.id )
  st = Region.find_by_key_and_country_id!( 'st', at.id )
  s  = Region.find_by_key_and_country_id!( 's',  at.id )

  breweries_at = at.breweries
  breweries_n  = n.breweries
  breweries_o  = o.breweries
  breweries_st = st.breweries
  breweries_s  = s.breweries

  cache = load_lat_lng( './geo/at-cities.csv' )
  ## dump for debugging
  pp cache

  build_map_for( breweries_at, './build/at.geojson', cache )
  build_map_for( breweries_n,  './build/n.geojson',  cache )
  build_map_for( breweries_o,  './build/o.geojson',  cache )
  build_map_for( breweries_st, './build/st.geojson', cache )
  build_map_for( breweries_s,  './build/s.geojson',  cache )

end # method build_map_at


def build_map_be
  puts 'hello from build_map_be'

  be  = Country.find_by_key!( 'be' )

  breweries_be = be.breweries

  cache = load_lat_lng( './geo/be-cities.csv' )   
  ## dump for debugging
  pp cache

  build_map_for( breweries_be, './build/be.geojson', cache )

  ###
  check_breweries_for_missing_city( breweries_be, cache )

end  # method build_map_de



###
# note: geojson order is lng/lat !!!!
#
# A position is represented by an array of numbers.
# There must be at least two elements, and may be more.
# The order of elements must follow x, y, z order
# (easting, northing, altitude for coordinates in a projected coordinate reference system,
#  or longitude, latitude, altitude for coordinates in a geographic coordinate reference system).


def gen_geojson( brewery, latlng )
  
  marker_color = if brewery.l?
      '#ff0000'     ## red
    elsif brewery.m?
      '#0000ff'     ## blue
    elsif brewery.brewpub?
      '#ffd700'      ## gold (yellow-ish)
    else
      '#008000'      ## green  - (small-size brewery)
    end

  marker_size =  if brewery.l?
      'large'
    elsif brewery.m?
      'medium'
    elsif brewery.brewpub?
      'small'
    else
      'small'
    end

  brewery_type = if brewery.l?
      'berwery (l)'
    elsif brewery.m?
      'brewery (m)'
    elsif brewery.brewpub?
      'brewpub'
    else
      'brewery'
    end


  hash = {
    'type' => 'Feature',
    'geometry' => {
        'type' => 'Point',
        'coordinates' => [ latlng.lng, latlng.lat  ]
    },
    'properties' => {
        'title'        => brewery.title,    ## note: use title (pre-defined/standard) name for auto-hover for marker (does it work?)
        'description'  => brewery.address,   ### use description for auto-hover? (does it work?)
        'city'         => brewery.city.title,
        'state'        => brewery.city.region.title.gsub( /\[[^\]]+\]/, '' ).strip,  # NOTE: remove translations e.g. [Viena] etc
        'web'          => brewery.web, 
        'type'         => brewery_type,
        'marker-color' => marker_color,
        'marker-size'  => marker_size
    }
  }

  hash
end



