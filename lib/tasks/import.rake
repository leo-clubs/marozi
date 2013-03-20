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
      begin
        year = md['year'].gsub(/\//, '-')
        obj = Import::MultipleDistrictImporter.new(md, year).build_model
        puts "File imported"
        puts "Now saving db entities"
        obj.save!
        puts "Imported #{index+1} of #{size} multiple districts"
        puts 'Setting max id'
        Setting.new(key: :max_ids).save!
        puts 'Creating MD Committees'
        obj.create_committees %i{activity hdleo it leolife merlo pr}
        [MultipleDistrict, Committee, District, Club, Member].each{|e| e.set_max_id}
        puts 'Setting current year'
        Setting.new(key: :"multiple_district_#{obj.leo_id}", current_year: year).save!
      rescue Exception => e
        puts "Error occured: (message: #{e.message})"
        puts "Backtrace:"
        puts e.backtrace.join '\n'
      end
    end
    puts 'Import finnished successfully'
  end
end