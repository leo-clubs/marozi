FactoryGirl.define do
  [
    :max_id_member,
    :max_id_club,
    :max_id_district,
    :max_id_office,
  ].each do |name|
      factory name, class: Setting do
      key name.to_s
      value '0'
    end
  end

  factory :setting do
    key 'key'
    value 'value'
  end
end