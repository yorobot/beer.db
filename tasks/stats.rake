

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

