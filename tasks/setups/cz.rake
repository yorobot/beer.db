

task :cz => :importbuiltin do
  BeerDb.read_setup( 'setups/all', CZ_INCLUDE_PATH )
end

task :cz_test => :importbuiltin do
  BeerDb.read_setup( 'setups/test', CZ_INCLUDE_PATH )
end

task :cz_l => :importbuiltin do
  BeerDb.read_setup( 'setups/breweries_(l)', CZ_INCLUDE_PATH )
end


#####
# export cities for geocoding

task :cz_cities => :env do

  require './scripts/cities'

  save_cities_for_breweries_for_country( 'cz' )

  puts 'Done.'
end

