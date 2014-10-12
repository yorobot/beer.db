
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

