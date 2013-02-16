source 'https://rubygems.org'

gem 'rake'
gem 'rails',     github: 'rails/rails'
gem 'arel',      github: 'rails/arel'
gem 'activerecord-deprecated_finders', github: 'rails/activerecord-deprecated_finders'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sprockets-rails', github: 'rails/sprockets-rails'

  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass'
  gem 'coffee-rails', github: 'rails/coffee-rails'
end

gem 'turbolinks'
gem 'jquery-rails'
gem 'sass-rails',   github: 'rails/sass-rails'
gem 'haml-rails', '< 0.4'

gem 'mongoid', github: 'mongoid/mongoid'

gem 'bson_ext'
gem 'devise'
gem 'nokogiri', require: false

gem 'pry'
gem 'pry-rails'

group :test, :development do
  gem 'pry-doc'
  gem 'pry-nav'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'guard'
  gem 'guard-rspec'
  #gem 'guard-jasmine-headless-webkit'
  gem 'factory_girl_rails'
  gem 'thin'
  #gem 'jasmine-rails'
  gem 'coveralls', require: false
  gem 'rb-inotify', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-fchange', require: false
end

group :production do
  gem 'therubyracer', require: 'v8'
end