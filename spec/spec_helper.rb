ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/autorun'
require 'rspec/rails'
require 'nokogiri'
require 'coveralls'

%w{spec/support lib}.each do |dir|
  Dir[Rails.root.join("#{dir}/**/*.rb")].each {|f| require f}
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = "random"
  config.include FactoryGirl::Syntax::Methods
end

RSpec::Matchers.define :have_same_attributes_as do |expected|
  match do |actual|
    if actual.class != Array
      actual = [actual]
      expected = [expected]
    end
    raise "different size: expected: #{expected.size} actual: #{actual.size}" if expected.size != actual.size
    ignored = ['_id']

    [actual, expected].each{|a| a.map!{|c| c.attributes.except(*ignored)}}
    actual == expected
  end
end

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = :truncation
    DatabaseCleaner[:mongoid].clean_with :truncation
  end

  config.before(:each) do
    FactoryGirl.reload
    DatabaseCleaner[:mongoid].start
  end

  config.after(:each) do
    DatabaseCleaner[:mongoid].clean
  end
end

def xml_fixture file_name
  f = File.open("#{Rails.root}/spec/fixtures/import/#{file_name}.xml")
  Nokogiri::XML(f).element_children.first
end

Coveralls.wear!('rails')