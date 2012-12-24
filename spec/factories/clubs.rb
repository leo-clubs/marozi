FactoryGirl.define do
  factory :club, class: Club do
    sequence(:leo_id) {|n| "0587#{"%02d" % n}"}
    name 'Raunenhausen'
    founded_at Date.new(1983, 3,19)
    chartered_at Date.new(1984, 2,29)
    godfather 'LC Raunenhausen'
  end
end