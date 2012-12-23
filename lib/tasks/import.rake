namespace :db do
  require 'nokogiri'

  desc 'import the member data from the german XML export'
  task :import_from_xml, :file_path do |t, args|
    f = File.open(args[:file_path])
    doc = Nokogiri::XML(f)
    f.close

    puts doc.xpath("//CLUB").first.inspect
  end

end