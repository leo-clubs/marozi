district_names  = %w{VW KL UV}

FactoryGirl.define do
  factory :district do
    sequence(:leo_id) {|n| 28700 + n }
    sequence(:name)   {|n| district_names[n] }
    year '2012-2013'
    multiple_district

    district_names.each_with_index do |district_name, index|
      trait "district_#{index+1}".to_sym do
        name district_name
      end
    end

    after(:create) do |district, evaluator|
      FactoryGirl.create_list(:club, Array(2..3).sample, district: district)
    end
  end
end