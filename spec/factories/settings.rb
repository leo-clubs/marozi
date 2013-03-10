FactoryGirl.define do
  factory :max_ids_setting, class: Setting do
    key :max_ids
    after(:build) do |setting|
      setting.write_attribute(:members, 0)
      setting.write_attribute(:clubs, 0)
      setting.write_attribute(:districts, 0)
      setting.write_attribute(:multiple_districts, 0)
      setting.write_attribute(:offices, 0)
      setting.write_attribute(:members, 0)
    end
  end
end