
desc 'print versions of gems'
task :about do
  puts ''
  puts 'gem versions'
  puts '============'
  puts "textutils #{TextUtils::VERSION}     (#{TextUtils.root})"
  puts "worlddb   #{WorldDb::VERSION}     (#{WorldDb.root})"
  puts "beerdb    #{BeerDb::VERSION}     (#{BeerDb.root})"

  ## todo - add LogUtils  LogDb ??  - check for .root too
end

