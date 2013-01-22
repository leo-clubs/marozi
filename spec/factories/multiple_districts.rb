FactoryGirl.define do
  factory :multiple_district do
    sequence(:leo_id) {|n| 23 + n}
    sequence(:name)   {|n| '111' }
    year '2012-2013'
  end
end