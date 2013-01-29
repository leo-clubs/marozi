source 'https://rubygems.org'

gem 'rake'
gem 'rails',     github: 'rails/rails'
gem 'arel',      github: 'rails/arel'
gem 'activerecord-deprecated_finders', github: 'rails/activerecord-deprecated_finders'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sprockets-rails', github: 'rails/sprockets-rails'
  gem 'sass-rails',   github: 'rails/sass-rails'
  gem 'coffee-rails', github: 'rails/coffee-rails'

  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass'
end

gem 'jquery-rails'
gem 'haml-rails'
gem 'coffee-filter'
gem 'turbolinks'

gem 'mongoid', github: 'mongoid/mongoid', branch: '4.0.0-dev'

gem 'bson_ext'
gem 'devise'
gem 'nokogiri', require: false

group :test, :development do
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-nav'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-jasmine'
  gem 'factory_girl_rails'
  gem 'thin'
  gem 'jasminerice', github: 'bradphelan/jasminerice'
  gem 'coveralls', require: false
  gem 'rb-inotify', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-fchange', require: false
end

group :production do
  gem 'therubyracer', require: 'v8'
end