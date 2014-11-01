# encoding: utf-8

require './geo/search'



CITIES_IN_PATH  = './geo/de-cities-input.txt'
CITIES_OUT_PATH = './geo/de-cities.csv'

cities = load_cities( CITIES_IN_PATH, 'de' )
pp cities


cache = load_responses( CITIES_OUT_PATH, 'de' )


cities.each_with_index do |city,i|
  ## next if i > 4

  puts "#{i} #{city.name} / #{city.region_name}"

  entry = cache[city.name]
  if entry
    puts "entry found; skipping >#{city.name}<"
  else
    res = search_city( city )
    ## pp res

    cache[ city.name ] = res

    sleep( 0.4 )  # wait 400ms
  end
end

### reorder cache in order of input file

cache2 = {}
cities.each do |city|
  entry = cache[city.name]
  if entry
    cache2[city.name] = entry
  else
    puts "*** warn: no cache entry found for #{city.name}"
  end
  
  ## todo: delete cache entry; at the end dump entries if any remaing w/ warning
end


cache = cache2  # delete old "unordered" cache

save_responses( CITIES_OUT_PATH, cache )


puts 'bye'

