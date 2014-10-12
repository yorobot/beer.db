

task :world => :importbuiltin do
  BeerDb.read_setup( 'setups/all', WORLD_INCLUDE_PATH )
end

task :ch => :importbuiltin do
  BeerDb.read_setup( 'setups/all', CH_INCLUDE_PATH )
end

task :cz => :importbuiltin do
  BeerDb.read_setup( 'setups/all', CZ_INCLUDE_PATH )
end

task :ie => :importbuiltin do
  BeerDb.read_setup( 'setups/all', IE_INCLUDE_PATH )
end

task :be => :importbuiltin do
  BeerDb.read_setup( 'setups/all', BE_INCLUDE_PATH )
end

task :nl => :importbuiltin do
  BeerDb.read_setup( 'setups/all', NL_INCLUDE_PATH )
end

task :ca => :importbuiltin do
  BeerDb.read_setup( 'setups/all', CA_INCLUDE_PATH )
end

task :us => :importbuiltin do
  BeerDb.read_setup( 'setups/all', US_INCLUDE_PATH )
end

task :mx => :importbuiltin do
  BeerDb.read_setup( 'setups/all', MX_INCLUDE_PATH )
end

task :jp => :importbuiltin do
  BeerDb.read_setup( 'setups/all', JP_INCLUDE_PATH )
end
