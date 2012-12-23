FactoryGirl.define do
  factory :xml_home_address, class: Address do
    id                    -1
    type                  :home
    street                'Karl-Jaspers-Str. 86'
    zip                   '71182'
    city                  'Klemensland'
    country               'Germany'
    email_address         'andrea.gollnow@gilde.ch'
    phone_number          '04 55- 9 63 37 50'
  end
end