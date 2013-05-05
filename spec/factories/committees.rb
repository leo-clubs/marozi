FactoryGirl.define do
  factory :committee, class: Committee do
    sequence(:oid) {|n| 92300 + n}
    year '2012-2013'
  end
end