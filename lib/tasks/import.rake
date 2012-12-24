namespace :db do
  require 'nokogiri'
  require_relative '../helper/import'

  desc 'import the member data from the german XML export'
  task :import_from_xml, [:file_path] => [:environment] do |t, args|
    puts 'und los gehts'
    f = File.open(args[:file_path])
    doc = Nokogiri::XML(f)
    f.close

    clubs = doc.xpath(".//CLUB")
    size = clubs.size

    puts 'Starting Import'
    clubs.each_with_index do |club, index|
      begin
        Import::ClubFactory.build_model(club, true)
        puts "Imported #{index+1} of #{size} clubs"
      rescue Exception => e
        puts "Error: on club: #{club.inspect} (message: #{e.message})"
        puts "Backtrace: #{e.backtrace}"
      end
    end
    puts 'Import finnished successfully'
  end

end