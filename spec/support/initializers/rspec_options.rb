require_relative './../../../config/environment'
require 'rspec/autorun'
require 'rspec/rails'
require 'database_cleaner'

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = 'random'
  config.include FactoryGirl::Syntax::Methods
  config.filter_run_excluding skip: true

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    FactoryGirl.reload
    DatabaseCleaner.clean
    DatabaseCleaner.start
    #create(:max_ids_setting)
  end
end