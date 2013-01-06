FactoryGirl.define do
  factory :member, class: Member do
    sequence(:leo_id) {|n| 87200 + n}
    year '2012-2013'

    factory :simple_member, class: Member do
      first_name            'Susanne'
      last_name             'von Orliwitzki'
      gender                :female
      profession            'Jurastudentin'
      club
    end

    factory :president_member, class: Member do
      first_name            'Susanne'
      last_name             'von Orliwitzki'
      gender                :female
      profession            'Jurastudentin'
      club
    end
  end
end