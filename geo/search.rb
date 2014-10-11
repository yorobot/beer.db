# encoding: utf-8


require 'pp'
require 'cgi'
require 'net/http'
require 'uri'
require 'json'



puts 'hello geo/search'


def load_cities( path )
  ary = []
  last_region_name = '?'
  File.open( path ).each_line do |line|

    if line =~ /^\s*#/
      next   ## skip comments
    end

    if line =~ /^\s*$/
      next   ## skip blank lines
    end
 
    ## remove end-of-line comments
    
    line = line.sub( /\s+#+\s+.*$/, '' )   ## must have leading and trailing space!!

    if line =~ /^\s*\-\s*/   # if line starts w/ dash (-) assume its a header (bundesland)
      last_region_name = line.sub('-','').strip  # remove first dash (-) and than all leading n trailing spaces
      puts "region_name=>#{last_region_name}"
      next   ## skip header
    end


    name = line.strip  # remove leading n trailing spaces
    
    puts "name=>#{name}<"
    city = City.new
    city.name = name
    city.region_name = last_region_name
    ary << city
  end

  ary
end


def search_city( city )
  
  base_url = 'http://open.mapquestapi.com/nominatim/v1/search.php'
  params = {
    format: 'json',
    city: city.name,
    countrycodes: 'at'
  }

  query_params = []
  params.each do |k,v|
    query_params << "#{k}=#{CGI.escape(v)}"
  end

  search_url = "#{base_url}?#{query_params.join('&')}"

  pp search_url


  uri = URI.parse( search_url )

  http = Net::HTTP.new( uri.host, uri.port )

  response = http.request( Net::HTTP::Get.new(uri.request_uri) )

  pp response.code             # => '301'
  ## response.body             # => The body (HTML, XML, blob, whatever)

  puts "content-type: #{response['content-type']}"
  puts "content-length: #{response['content-length']}"

  json = response.body
  pp json[0..20]

  data = JSON.parse( json )
  puts "data.class.name: #{data.class.name}, data.size: #{data.size}"

  city_res = CityResponse.new
  city_res.code = response.code
  city_res.size = data.size

  if data.size > 0
    if data.size == 1
      ## pp data[0]   ## print first entry
      city_rec = CityRecord.new
      city_rec.from_hash( data[0] )
      city_res.rec = city_rec
    else
      ## try match for region_name in display_name e.g. Burgenland
      ##  for now assumes/works only for one city/place name per region (bundesland/province)
      data.each do |entry|
        if entry['display_name'] =~ /#{city.region_name}/
          ## pp entry   ## print first entry
          city_rec = CityRecord.new
          city_rec.from_hash( entry )
          city_res.rec = city_rec
          puts " **** bingo"
          break ## bingo
        else
          puts " no match: #{entry['display_name']}"
        end
      end
    end
  end

  city_res
end



class City
  attr_accessor :name
  attr_accessor :region_name  # e.g. bundesland e.g. Wien, Burgendland, etc.
  
  def initialize
    @name = '?'
    @region_name = '?'
  end
end


class CityResponse

  attr_accessor :code # http status code
  attr_accessor :size # no of records returned
  attr_accessor :rec  # first record

  def initialize
    @code = '?'
    @size = '?'
    @rec  = CityRecord.new
  end

  def to_ary
    values = []
    values << code
    values << size
    values += rec.to_ary
  end

end # class CityResponse


class CityRecord

  def initialize
    @place_id = '?'
    @lat      = '?'
    @lon      = '?'
    @osmclass  = '?'
    @osmtype   = '?'
    @display_name = '?'
  end


  def from_ary( ary )
    @place_id = ary[0]
    @lat      = ary[1]
    @lon      = ary[2]
    @osmclass  = ary[3]
    @osmtype   = ary[4]
    @display_name = ary[5]
    self   # note: return self for allowing chaining calls
  end

  def from_hash( h )
    @place_id = h['place_id']
    @lat      = h['lat']
    @lon      = h['lon']
    @osmclass  = h['class']
    @osmtype   = h['type']
    @display_name = h['display_name']
    self   # note: return self for allowing chaining calls
  end

  def to_ary
    [
      @place_id,
      @lat,
      @lon,
      @osmclass,
      @osmtype,
      @display_name.gsub(',','|')  # note: replace comma w/ pipe
    ]
  end

end # class CityRecord


def load_responses( path )
  hash = {}

  File.open( path, 'r').each_line do |line|

    values = line.split(',')
    key = values[0]

    res = CityResponse.new
    res.code = values[1]
    res.size = values[2]
    res.rec = CityRecord.new.from_ary( values[3..-1] )

    hash[ key ] = res
  end
  
  hash
end

def save_responses( path, hash )
  File.open( path, 'w') do |file|

    hash.each do |k,v|
      values = []
      values << k
      values += v.to_ary
      file.puts values.join( ',' )
    end

  end
end


cities = load_cities( './geo/at-cities-input.txt' )
pp cities


cache = load_responses( './geo/at-cities.csv' )

cities.each_with_index do |city,i|
  ## next if i > 2

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

save_responses( './geo/at-cities.csv', cache )


puts 'bye'

