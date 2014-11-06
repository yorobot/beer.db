
require 'pp'
require 'zip'

puts 'hello from testzip'


AT_ZIP_PATH = './build/at-austria-master.zip'

def find_entry_in_zip( zip_file, name )

  ### allow prefix (path)
  ###    e.g. assume all files relative to setup manifest
  ## e.g. at-austria-master/setups/all.txt or
  ##      be-belgium-master/setups/all.txt
  ##  for
  ##    setups/all.txt
  ###

  query = "**/#{name}"

  candidates = zip_file.glob( query )
  pp candidates

  ## note: returns an array of Zip::Entry

  ## use first entry as match; todo: issue warning if more than one entries/matches!!
  fullpath = candidates[0].name
  puts "  fullpath >>#{fullpath}<<"

  prefix = fullpath[ 0...(fullpath.size-name.size) ]
  puts "  prefix >>#{prefix}<<"
  puts "  empty >>#{fullpath[0...0]}<<"

end


Zip::File.open( AT_ZIP_PATH ) do |zip_file|
  # Handle entries one by one
  zip_file.each do |entry|
    if entry.directory?
      puts "found directory >>#{entry.name}<<"
    else
      puts "found file >>#{entry.name}<<"
    end
  end

  find_entry_in_zip( zip_file, 'setups/all.txt' )
  find_entry_in_zip( zip_file, 'at-austria-master/setups/all.txt' )
  
  entry = zip_file.find_entry( 'at-austria-master/setups/all.txt' )
  content = entry.get_input_stream().read()
  ## todo/fix: add force encoding to utf-8 ??
  ##  check!!!
  ##  clean/prepprocess lines
  ##  e.g. CR/LF (/r/n) to LF (e.g. /n)
  pp content
end




puts 'bye'

