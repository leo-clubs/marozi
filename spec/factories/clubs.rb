club_names = %w{Raunenhausen Biberach Buxtehude Linsengericht Fucking Busenbach Entenhausen}

FactoryGirl.define do
  factory :club do
    sequence(:leo_id) {|n| "0587#{"%02d" % n}"}
    sequence(:name) {|n| club_names[n]}
    sequence(:godfather) {|n| godfather "LC #{club_names[n]}"}

    founded_at Date.new(1983, 3, 19)
    chartered_at Date.new(1984, 2, 29)
  end
end