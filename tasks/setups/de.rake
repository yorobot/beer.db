

task :de => :importbuiltin do
  BeerDb.read_setup( 'setups/all', DE_INCLUDE_PATH )
end


