if ENV['CI']
  require 'coveralls'
  Coveralls.wear!('rails')
end