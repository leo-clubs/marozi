FactoryGirl.define do
  factory :multiple_district do
    sequence(:oid) {|n| 23 + n}
    sequence(:name)   {|n| '111' }
    year '2012-2013'

    factory :multiple_districts_with_it_office do
      after(:create) do | md |
        FactoryGirl.create(:office, name: :it_appointee, parent_id: md.oid)
      end
    end

    factory :multiple_district_with_setting do
      after(:create) do | md |
        FactoryGirl.create(
          :setting,
          multiple_district: md.oid,
        )
      end
    end
  end
end