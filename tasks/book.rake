

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

