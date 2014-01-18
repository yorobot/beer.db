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
AT_INCLUDE_PATH               = "#{OPENBEER_ROOT}/at-austria"
IE_INCLUDE_PATH               = "#{OPENBEER_ROOT}/ie-ireland"
MX_INCLUDE_PATH               = "#{OPENBEER_ROOT}/mx-mexico"



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
  AT_INCLUDE_PATH:           #{AT_INCLUDE_PATH}
  IE_INCLUDE_PATH:           #{IE_INCLUDE_PATH}
  MX_INCLUDE_PATH:           #{MX_INCLUDE_PATH}
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

task :at => :importbuiltin do
  BeerDb.read_setup( 'setups/all', AT_INCLUDE_PATH )
end

task :ie => :importbuiltin do
  BeerDb.read_setup( 'setups/all', IE_INCLUDE_PATH )
end

task :mx => :importbuiltin do
  BeerDb.read_setup( 'setups/all', MX_INCLUDE_PATH )
end



#########################################################
# note: change deps to what you want to import for now

task :importbeer => [:ie] do
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
