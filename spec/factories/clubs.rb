club_names = %w{Raunenhausen Biberach Buxtehude Linsengericht Fucking Busenbach Entenhausen}

FactoryGirl.define do
  factory :club do
    sequence(:oid) {|n| 58700 + n}
    sequence(:name) {|n| club_names[n]}
    sequence(:godfather) {|n| "LC #{club_names[n]}"}
    year '2012-2013'

    founded_at Date.new(1983, 3, 19)
    chartered_at Date.new(1984, 2, 29)
    district

    factory :club_with_members do
      after(:create) do | club |
        FactoryGirl.create_list(:member, 5, club: club)
      end
    end
  end
end