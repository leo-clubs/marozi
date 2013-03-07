FactoryGirl.define do
  factory :office, class: Office do
    sequence(:leo_id) {|n| 1400 + n}
    year '2012-2013'

    factory :president_office, class: Office do
      name :p
    end

    factory :secretary_office, class: Office do
      name :s
    end
  end
end