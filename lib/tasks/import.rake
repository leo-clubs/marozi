namespace :db do
  require 'nokogiri'

  %w{lib/import}.each do |dir|
    Dir[Rails.root.join("#{dir}/**/*.rb")].each {|f| require f}
  end


  desc 'import the member data from the german XML export'
  task :import_from_xml, [:file_path] => [:environment] do |t, args|
    f = File.open(args[:file_path])
    doc = Nokogiri::XML(f)
    f.close

    multiple_districts = doc.xpath(".//MDISTRICT")
    size = multiple_districts.size

    puts 'Starting Import'
    multiple_districts.each_with_index do |md, index|
      obj = nil
      begin
        year = md['year'].gsub(/\//, '-')
        obj = Import::MultipleDistrictImporter.new(md, year).build_model
        puts "File imported"
        puts "Now saving db entities"
        obj.save!
        puts "Imported #{index+1} of #{size} multiple districts"
        puts 'Creating MD Committees'
        puts 'Import finnished successfully'
      rescue Exception => e
        puts "Error occured: (message: #{e.message})"
        puts "Backtrace:"
        puts e.backtrace
        puts "Import did not finnish successfully"
      end
      puts 'Creating Offices'
      OfficeCreator.create_offices_for_members doc, year
      OfficeCreator.create_offices_for_appointees doc, year
      obj.create_committees %i{activity hdleo it leolife merlo pr}
    end
  end
end