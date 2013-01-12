def xml_fixture file_name
  f = File.open("#{Rails.root}/spec/fixtures/import/#{file_name}.xml")
  Nokogiri::XML(f).element_children.first
end