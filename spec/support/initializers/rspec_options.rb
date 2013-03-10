require_relative './../../../config/environment'
require 'rspec/autorun'
require 'rspec/rails'

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = 'random'
  config.include FactoryGirl::Syntax::Methods
  config.filter_run_excluding skip: true

  config.before(:each) do
    FactoryGirl.reload
    Import::OfficeFactory.reset_counter
    Mongoid.purge!
    create(:max_ids_setting)
  end
end