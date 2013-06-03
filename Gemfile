source 'http://rubygems.org'

gem 'rake'
gem 'rails',     github: 'rails/rails', tag: 'v4.0.0.rc1'
gem 'pg'
gem 'arel',      github: 'rails/arel'
gem 'activerecord-deprecated_finders', github: 'rails/activerecord-deprecated_finders'
gem 'symbolize'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sprockets-rails', github: 'rails/sprockets-rails'

  gem 'uglifier', '>= 1.0.3'
  gem 'bootstrap-sass'
  gem 'coffee-rails', github: 'rails/coffee-rails'
  gem 'angularjs-rails'
end

gem 'turbolinks', github: 'rails/turbolinks'
gem 'jquery-rails', github: 'rails/jquery-rails' # use rubygems version for >2.2.1 (see https://github.com/rails/jquery-rails/pull/117)
gem 'sass-rails', github: 'rails/sass-rails'
gem 'haml-rails', github:  'indirect/haml-rails' # use rubygems version for >0.4 (see https://github.com/indirect/haml-rails/issues/42)
gem 'haml'

gem 'rails-i18n'

gem 'bson_ext'
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
  gem 'guard-jasmine'
  gem 'factory_girl_rails'
  gem 'thin'
  gem 'database_cleaner'
  gem 'jasminerice', github: 'bradphelan/jasminerice'
  gem 'coveralls', require: false
  gem 'rb-inotify', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-fchange', require: false
end

group :production do
  gem 'therubyracer', require: 'v8'
end