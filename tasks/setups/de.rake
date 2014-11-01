

task :de => :importbuiltin do
  BeerDb.read_setup( 'setups/all', DE_INCLUDE_PATH )
end


##########################################
##  build bayern (by) / baviria only

task :by => :importbuiltin do
  BeerDb.read_setup( 'setups/all', BY_INCLUDE_PATH )
end

