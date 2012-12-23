require 'spec_helper'

describe 'import'  do
  describe 'address' do
    let(:address) {xml_fixture('address').element_children.first}

    it 'should load all address data correctly' do
      a = Import::AddressFactory.build_model address
      a.should be_a(Address)
      a.type.should eq :home
      a.street.should eq 'Karl-Jaspers-Str. 86'
      a.zip.should eq '71182'
      a.city.should eq 'Klemensland'
      a.country.should eq 'Germany'
    end
  end

  describe 'member' do
    let(:member) {xml_fixture('member').element_children.first}

    it 'should load simple member data correctly' do
      m = Import::MemberFactory.build_model member
      m.should be_a(Member)
      m.member_id.should eq '027146'
      m.first_name.should eq 'Angela'
      m.last_name.should eq 'vom Mrugalla'
      m.gender.should eq :female
      m.date_of_birth.should eq Date.new(1988, 11, 12)
      m.member_since.should eq Date.new(2008, 7, 1)
      m.languages.sort.should eq [:de, :en, :fr, :it]
    end
  end
end