

task :de => :importbuiltin do
  BeerDb.read_setup( 'setups/all', DE_INCLUDE_PATH )
end


##########################################
##  build bayern (by) / baviria only

task :by => :importbuiltin do
  BeerDb.read_setup( 'setups/all', BY_INCLUDE_PATH )
end

task :by_l => :importbuiltin do
  BeerDb.read_setup( 'setups/breweries_(l)', BY_INCLUDE_PATH )
end


#####
# export cities for geocoding

task :by_cities => :env do

  require './scripts/cities'
  
  check_breweries()

  puts 'Done.'
end

