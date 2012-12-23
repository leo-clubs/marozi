require 'spec_helper'

describe 'import'  do
  describe 'address' do
    let(:address) {Import::AddressFactory.build_model(xml_fixture('address').element_children.first)}

    it 'should load all address data correctly' do
      address.should be_a(Address)
      address.type.should eq :home
      address.street.should eq 'Karl-Jaspers-Str. 86'
      address.zip.should eq '71182'
      address.city.should eq 'Klemensland'
      address.country.should eq 'Germany'
    end
  end

  describe 'member' do
    let(:member) {Import::MemberFactory.build_model(xml_fixture('member').element_children.first)}

    it 'should load simple member data correctly' do
      member.should be_a(Member)
      member.member_id.should eq '027146'
      member.first_name.should eq 'Angela'
      member.last_name.should eq 'vom Mrugalla'
      member.gender.should eq :female
      member.date_of_birth.should eq Date.new(1988, 11, 12)
      member.member_since.should eq Date.new(2008, 7, 1)
      member.languages.sort.should eq [:de, :en, :fr, :it]
    end
  end
end