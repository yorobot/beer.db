#######################################
# build script (Ruby make)
#
#  use:
#   $ rake   or
#   $ rake build     - to build beer.db from scratch
#
#   $ rake update    - to update beer.db
#
#   $ rake -T        - show all tasks


BUILD_DIR = "./build"

# -- output db config
BEER_DB_PATH = "#{BUILD_DIR}/beer.db"


# -- input repo sources config
OPENMUNDI_ROOT = "../../openmundi"
OPENBEER_ROOT = ".."

WORLD_DB_INCLUDE_PATH = "#{OPENMUNDI_ROOT}/world.db"


WORLD_INCLUDE_PATH            = "#{OPENBEER_ROOT}/world"

DE_INCLUDE_PATH               = "#{OPENBEER_ROOT}/de-deutschland"
AT_INCLUDE_PATH               = "#{OPENBEER_ROOT}/at-austria"
CH_INCLUDE_PATH               = "#{OPENBEER_ROOT}/ch-confoederatio-helvetica"
CZ_INCLUDE_PATH               = "#{OPENBEER_ROOT}/cz-czech-republic"
IE_INCLUDE_PATH               = "#{OPENBEER_ROOT}/ie-ireland"
BE_INCLUDE_PATH               = "#{OPENBEER_ROOT}/be-belgium"
NL_INCLUDE_PATH               = "#{OPENBEER_ROOT}/nl-netherlands"

CA_INCLUDE_PATH               = "#{OPENBEER_ROOT}/ca-canada"
US_INCLUDE_PATH               = "#{OPENBEER_ROOT}/us-united-states"
MX_INCLUDE_PATH               = "#{OPENBEER_ROOT}/mx-mexico"

JP_INCLUDE_PATH               = "#{OPENBEER_ROOT}/jp-japan"



DB_CONFIG = {
  adapter:    'sqlite3',
  database:   BEER_DB_PATH
}


#######################
#  print settings

settings = <<EOS
*****************
settings:
  WORLD_DB_INCLUDE_PATH: #{WORLD_DB_INCLUDE_PATH}

  WORLD_INCLUDE_PATH:        #{WORLD_INCLUDE_PATH}
  DE_INCLUDE_PATH:           #{DE_INCLUDE_PATH}
  AT_INCLUDE_PATH:           #{AT_INCLUDE_PATH}
  CH_INCLUDE_PATH:           #{CH_INCLUDE_PATH}
  CZ_INCLUDE_PATH:           #{CZ_INCLUDE_PATH}
  IE_INCLUDE_PATH:           #{IE_INCLUDE_PATH}
  BE_INCLUDE_PATH:           #{BE_INCLUDE_PATH}
  NL_INCLUDE_PATH:           #{NL_INCLUDE_PATH}
  CA_INCLUDE_PATH:           #{CA_INCLUDE_PATH}
  US_INCLUDE_PATH:           #{US_INCLUDE_PATH}
  MX_INCLUDE_PATH:           #{MX_INCLUDE_PATH}
  JP_INCLUDE_PATH:           #{JP_INCLUDE_PATH}
*****************
EOS

puts settings




task :default => :build

directory BUILD_DIR


task :clean do
  rm BEER_DB_PATH if File.exists?( BEER_DB_PATH )
end


task :env => BUILD_DIR do
  require 'worlddb'   ### NB: for local testing use rake -I ./lib dev:test e.g. do NOT forget to add -I ./lib
  require 'beerdb'
  require 'logutils/db'

  LogUtils::Logger.root.level = :info

  pp DB_CONFIG
  ActiveRecord::Base.establish_connection( DB_CONFIG )
end

task :create => :env do
  LogDb.create
  WorldDb.create
  BeerDb.create
end

task :importworld => :env do
  # populate world tables
  WorldDb.read_setup( 'setups/sport.db.admin', WORLD_DB_INCLUDE_PATH, skip_tags: true )
  # WorldDb.stats
end

task :importbuiltin => :env do
  # BeerDb.read_builtin
  LogUtils::Logger.root.level = :debug
end



task :world => :importbuiltin do
  BeerDb.read_setup( 'setups/all', WORLD_INCLUDE_PATH )
end

task :de => :importbuiltin do
  BeerDb.read_setup( 'setups/all', DE_INCLUDE_PATH )
end

task :at => :importbuiltin do
  BeerDb.read_setup( 'setups/all', AT_INCLUDE_PATH )
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

#########################################################
# note: change deps to what you want to import for now

task :importbeer => [:be] do
  # BeerDb.stats
end


task :deletebeer => :env do
  BeerDb.delete!
end


desc 'build beer.db from scratch (default)'
task :build => [:clean, :create, :importworld, :importbeer] do
  puts 'Done.'
end

desc 'update beer.db'
task :update => [:deletebeer, :importbeer] do
  puts 'Done.'
end

desc 'pull (auto-update) beer.db from upstream sources'
task :pull => :env do
  BeerDb.update!
  puts 'Done.'
end


task :about do
  # todo: print versions of gems etc.
end

