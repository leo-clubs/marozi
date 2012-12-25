require 'spec_helper'

describe Import do
  describe Import::MemberFactory do
    subject {Import::MemberFactory.new(xml_fixture('member'), '2012-2013').build_model}
    let(:home_contact_info) { build(:xml_home_contact_info) }

    it 'should load simple member data correctly' do
      subject.should be_a(Member)
      subject.leo_id.should eq '027146'
      subject.year.should eq '2012-2013'
      subject.first_name.should eq 'Angela'
      subject.last_name.should eq 'vom Mrugalla'
      subject.gender.should eq :female
      subject.profession.should eq 'Stud. Jur.'
      subject.date_of_birth.should eq Date.new(1988, 11, 12)
      subject.member_since.should eq Date.new(2008, 7, 1)
      subject.languages.sort.should eq [:de, :en, :fr, :it]
    end

    it 'should load embedded member data correctly' do
      subject.contact_infos.should_not be_empty
      subject.contact_infos.should have_same_attributes_as([home_contact_info])
    end
  end
end