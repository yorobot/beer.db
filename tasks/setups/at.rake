
task :at => :importbuiltin do
  BeerDb.read_setup( 'setups/all', AT_INCLUDE_PATH )
end

task :at_pubs => :importbuiltin do
  BeerDb.read_setup( 'setups/brewpubs', AT_INCLUDE_PATH )
end

task :at_test => :importbuiltin do
  BeerDb.read_setup( 'setups/test', AT_INCLUDE_PATH )
end


task :at_w => :importbuiltin do
  BeerDb.read_setup( 'setups/w', AT_INCLUDE_PATH )
end

task :at_n => :importbuiltin do
  BeerDb.read_setup( 'setups/n', AT_INCLUDE_PATH )
end

task :at_b => :importbuiltin do
  BeerDb.read_setup( 'setups/b', AT_INCLUDE_PATH )
end

task :at_k => :importbuiltin do
  BeerDb.read_setup( 'setups/k', AT_INCLUDE_PATH )
end

task :at_st => :importbuiltin do
  BeerDb.read_setup( 'setups/st', AT_INCLUDE_PATH )
end

task :at_o => :importbuiltin do
  BeerDb.read_setup( 'setups/o', AT_INCLUDE_PATH )
end

task :at_s => :importbuiltin do
  BeerDb.read_setup( 'setups/s', AT_INCLUDE_PATH )
end

task :at_t => :importbuiltin do
  BeerDb.read_setup( 'setups/t', AT_INCLUDE_PATH )
end

task :at_v => :importbuiltin do
  BeerDb.read_setup( 'setups/v', AT_INCLUDE_PATH )
end


task :at_w_pubs => :importbuiltin do
  BeerDb.read_setup( 'setups/w_brewpubs', AT_INCLUDE_PATH )
end

task :at_n_pubs => :importbuiltin do
  BeerDb.read_setup( 'setups/n_brewpubs', AT_INCLUDE_PATH )
end

task :at_b_pubs => :importbuiltin do
  BeerDb.read_setup( 'setups/b_brewpubs', AT_INCLUDE_PATH )
end

