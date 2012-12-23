ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'nokogiri'

%w{spec/support lib}.each do |dir|
  Dir[Rails.root.join("#{dir}/**/*.rb")].each {|f| require f}
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end

def xml_fixture file_name
  f = File.open("#{Rails.root}/spec/fixtures/import/#{file_name}.xml")
  Nokogiri::XML(f)
end