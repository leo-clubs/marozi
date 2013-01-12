require 'nokogiri'

%w{lib}.each do |dir|
  Dir[Rails.root.join("#{dir}/**/*.rb")].each {|f| require f}
end