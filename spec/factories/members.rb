FactoryGirl.define do
  factory :member, class: Member do
    first_names = %{Susanne Hans Julia Dirk Maike Ulf Anna Sebastian Lisa Dieter Laura Matthias Maria}
    last_names = %{Müller Jansen Otto Schmidt Schmid Jacobs Maier}

    sequence(:oid) {|n| 87200 + n}
    year '2012-2013'
    status :active
    sequence(:gender) {|n| n % 2 == 0 ? :male : :female}
    sequence(:first_name) {|n| first_names[n]}
    sequence(:last_name) {|n| last_names[n]}

    factory :simple_member, class: Member do
      first_name            'Susanne'
      last_name             'von Orliwitzki'
      gender                'female'
      profession            'Jurastudentin'
      contact_infos         { [build(:contact_info)] }
      after(:create) {|member| create(:membership, member: member, club: member.club)}
      club
    end

    factory :president_member, class: Member do
      first_name            'Anna'
      last_name             'Heddinghausen'
      gender                'female'
      profession            'Jurastudentin'
      after(:create) do |member|
        create(:president_office, member: member, provides_offices: member.club)
        create(:membership, member: member, club: member.club)
      end
      club
    end

    factory :member_with_previous_memberships, class: Member do
      first_name            'Paul'
      last_name             'Promikus'
      gender                'male'
      profession            'BWL Student'
      after(:create) do |member|
        create(
          :membership,
          member: member,
          club_id: member.club.oid - 10,
          from: '2006-07-01'.to_date,
          to: '2010-06-30'.to_date,
        )
        create(
          :membership,
          member: member,
          club: member.club,
          from: '2010-07-01'.to_date,
          to: nil,
        )
      end
      club
    end
  end
end