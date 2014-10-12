
task :at => :importbuiltin do
  ## BeerDb.read_setup( 'setups/all', AT_INCLUDE_PATH )
  BeerDb.read_setup( 'setups/test', AT_INCLUDE_PATH )
end

