FactoryGirl.define do
  factory :simple_member, class: Member do
    leo_id                '087294'
    first_name            'Susanne'
    last_name             'von Orliwitzki'
    gender                :female
    profession            'Jurastudentin'
  end
end