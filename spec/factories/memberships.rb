# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :membership do
    year "MyString"
    member_id 1
    club_id 1
  end
end
