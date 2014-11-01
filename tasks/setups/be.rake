
task :be => :importbuiltin do
  BeerDb.read_setup( 'setups/all', BE_INCLUDE_PATH )
end

task :be_vwv => :importbuiltin do
  BeerDb.read_setup( 'setups/vwv', BE_INCLUDE_PATH )
end

#####
# export cities for geocoding

task :be_cities => :env do

  require './scripts/cities'

  save_cities_for_breweries_for_country( 'be' )

  puts 'Done.'
end