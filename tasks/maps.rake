
desc 'generate maps (geojson)'
task :maps => :env do

  require './scripts/geo'

  build_map()

  check_breweries_for_missing_city()

  puts 'Done.'
end
