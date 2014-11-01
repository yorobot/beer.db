
desc 'generate maps (geojson) for at'
task :maps_at => :env do

  require './scripts/geo'

  build_map_at()

  puts 'Done.'
end


desc 'generate maps (geojson) for at'
task :maps_de => :env do

  require './scripts/geo'

  build_map_de()

  puts 'Done.'
end


desc 'generate maps (geojson) for be'
task :maps_be => :env do

  require './scripts/geo'

  build_map_be()

  puts 'Done.'
end
