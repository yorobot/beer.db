# encoding: utf-8


require 'pp'
require 'cgi'
require 'net/http'
require 'uri'
require 'json'



puts 'hello geo/search'


def load_cities( path, country_code )
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

    ## check for postall code
    ##  must start line


    if line =~ /^\s*(\d{4})\s+/
      postal_code = $1.to_s
      line = line.sub( postal_code, '' )  # remove from line
    else
      postal_code = '?'
    end

    name = line.strip  # remove leading n trailing spaces

    puts "name=>#{name}<"
    city = City.new
    city.name = name
    city.region_name  = last_region_name
    city.postal_code  = postal_code   ## fix: change to post_code
    city.country_code = country_code 
    ary << city
  end

  ary
end



def search_city( city )
  
  base_url = 'http://open.mapquestapi.com/nominatim/v1/search.php'
  params = {
    format: 'json',
    q: "#{city.name}, #{city.region_name}",
    countrycodes: "#{city.country_code}"
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
  puts "data.class.name: #{data.class.name}, data.size (before): #{data.size}"

  city_res = CityResponse.new( city )
  city_res.code = response.code

  ## filter; only use class=place:* (excl. place:house) and boundary:administrative
  data2 = []
  data.each_with_index do |entry,i|
    ## skip place:house; otherwise include all places and boundary:administrative
    if (entry['class'] == 'place' && entry['type'] != 'house') ||
       (entry['class'] == 'boundary' && entry['type'] == 'administrative')

      ## check: must match bundesland/state too e.g. Burgendland etc.
      if entry['display_name'] =~ /#{city.region_name}/ &&
        data2 << entry
        puts "   add #{i}  #{entry['class']}:#{entry['type']} - #{entry['display_name']}"
      else
        puts "   skip #{i} #{entry['class']}:#{entry['type']} - #{entry['display_name']}" 
      end
    else
      puts "   skip #{i} #{entry['class']}:#{entry['type']} - #{entry['display_name']}" 
    end
  end
  data = data2

  puts "data.size (after): #{data.size}"

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
      data.each_with_index do |entry,i|
        if entry['display_name'] =~ /#{city.region_name}/
          ## pp entry   ## print first entry
          city_rec = CityRecord.new
          city_rec.from_hash( entry )
          city_res.rec = city_rec
          puts " **** bingo: #{i} -> #{entry['display_name']}"
          break ## bingo
        else
          puts " no match: #{i} -> #{entry['display_name']}"
        end
      end
    end
  end

  city_res
end



class City
  attr_accessor :name
  attr_accessor :postal_code   ### fix: change to post_code !!!
  attr_accessor :region_name  # e.g. bundesland e.g. Wien, Burgendland, etc.
  attr_accessor :country_code
  
  def initialize
    @name         = '?'
    @postal_code  = '?'   # note: use(s) string
    @region_name  = '?'
    @country_code = '?'
  end
end


class CityResponse

  attr_accessor :city

  attr_accessor :code # http status code
  attr_accessor :size # no of records returned
  attr_accessor :rec  # first record

  def initialize( city )
    @city = city

    @code = '?'
    @size = '?'
    @rec  = CityRecord.new
  end

  def to_ary
    values = []
    values << city.region_name
    values << city.postal_code
    values << city.name

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


def load_responses( path, country_code )
  hash = {}

  return hash  unless File.exists?( path )   ## no file; no need to read in


  File.open( path, 'r').each_line do |line|

    values = line.split(',')

    city = City.new
    city.region_name  = values[0]
    city.postal_code  = values[1]
    city.name         = values[2]
    city.country_code = country_code

    res = CityResponse.new( city )
    res.code = values[3]
    res.size = values[4]
    res.rec = CityRecord.new.from_ary( values[5..-1] )

    hash[ city.name ] = res
  end
  
  hash
end

def save_responses( path, hash )
  File.open( path, 'w') do |file|

    hash.each do |_,v|
      values = v.to_ary
      file.puts values.join( ',' )
    end

  end
end

