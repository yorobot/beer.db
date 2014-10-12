
desc 'generate maps (geojson)'
task :maps => :env do

  require './scripts/geo'

  build_map()

  puts 'Done.'
end
