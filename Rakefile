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

# stdlibs
require 'yaml'
require 'erb'
require 'pp'


## our code
require './settings'

## load database config from external file (easier to configure/change)
DB_HASH = YAML.load( ERB.new( File.read( './database.yml' )).result )
DB_CONFIG = DB_HASH[ 'default' ] ## for now just always use default section/entr




task :default => :build

directory BUILD_DIR


task :clean do
  ## note: was sqlite3 only (specific) => rm BEER_DB_PATH if File.exists?( BEER_DB_PATH )

  db_adapter = DB_CONFIG[ 'adapter' ]
  ### for sqlite3 delete/remove single-file database
  if db_adapter == 'sqlite3'
    db_database = DB_CONFIG[ 'database' ]
    rm db_database if File.exists?( db_database )
  else
    puts " clean: do nothing; no clean steps configured for db adapter >#{db_adapter}<"
  end
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
  ## BeerDb.read_setup( 'setups/all', AT_INCLUDE_PATH )
  BeerDb.read_setup( 'setups/test', AT_INCLUDE_PATH )
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

task :importbeer => [:at] do
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

desc 'build book (draft version) - The Free World Beer Book - from beer.db'
task :book => :env do

  PAGES_DIR = "#{BUILD_DIR}/pages"  # use PAGES_OUTPUT_DIR or PAGES_ROOT ??

  require './scripts/book'


  build_book()                # multi-page version
  ## build_book( inline: true )  # all-in-one-page version a.k.a. inline version

  puts 'Done.'
end


desc 'build book (release version) - The Free World Beer Book - from beer.db'
task :publish => :env do

  PAGES_DIR = "../book/_pages"  # use PAGES_OUTPUT_DIR or PAGES_ROOT ??

  require './scripts/book'

  build_book()                # multi-page version
  ## build_book( inline: true )  # all-in-one-page version a.k.a. inline version

  puts 'Done.'
end


desc 'print versions of gems'
task :about => :env do
  puts ''
  puts 'gem versions'
  puts '============'
  puts "textutils #{TextUtils::VERSION}     (#{TextUtils.root})"
  puts "worlddb   #{WorldDb::VERSION}     (#{WorldDb.root})"
  puts "beerdb    #{BeerDb::VERSION}     (#{BeerDb.root})"

  ## todo - add LogUtils  LogDb ??  - check for .root too
end


desc 'print stats for beer.db tables/records'
task :stats => :env do
  puts ''
  puts 'world.db'
  puts '========'
  WorldDb.tables

  puts ''
  puts 'beer.db'
  puts '======='
  BeerDb.tables
end


