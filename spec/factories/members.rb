first_names = %{Susanne Hans Julia Dirk Maike Ulf Anna Sebastian Lisa Dieter Laura Matthias Maria}
last_names = %{Müller Jansen Otto Schmidt Schmid Jacobs Maier}

FactoryGirl.define do
  factory :member, class: Member do
    sequence(:leo_id) {|n| 87200 + n}
    year '2012-2013'
    sequence(:first_name) {|n| first_names[n]}
    sequence(:last_name) {|n| last_names[n]}

    factory :simple_member, class: Member do
      first_name            'Susanne'
      last_name             'von Orliwitzki'
      gender                :female
      profession            'Jurastudentin'
      contact_infos         { [build(:contact_info)] }
      club
    end

    factory :president_member, class: Member do
      first_name            'Anna'
      last_name             'Heddinghausen'
      gender                :female
      profession            'Jurastudentin'
      before(:create) {|member| create(:president_office, member_id: member.leo_id, parent_id: member.club.leo_id)}
      club
    end
  end
end