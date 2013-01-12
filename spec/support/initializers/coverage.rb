if ENV["TRAVIS"] || ENV["COVERALLS_RUN_LOCALLY"]
  require 'coveralls'
  Coveralls.wear!('rails')
end