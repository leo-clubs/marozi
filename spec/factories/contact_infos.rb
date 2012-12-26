FactoryGirl.define do
  factory :xml_home_contact_info, class: ContactInfo do
    id                    -1
    type                  :home
    street                'Karl-Jaspers-Str. 86'
    zip                   '71182'
    city                  'Klemensland'
    country               'Germany'
    email_address         'andrea.gollnow@gilde.ch'
    phone_number          '04 55- 9 63 37 50'
    mobile_phone_number   '+49-1533-38452399'
    fax_number            '(04603) 1586999'
    homepage              'http://www.penisland.com'
  end
end