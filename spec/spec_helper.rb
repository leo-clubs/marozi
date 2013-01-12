ENV["RAILS_ENV"] = 'test'

['coverage', 'rspec_options'].each { |initializer| require_relative "support/initializers/#{initializer}"}

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}