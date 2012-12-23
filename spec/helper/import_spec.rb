require 'spec_helper'

describe 'import'  do
  describe 'address' do
    subject {Import::AddressFactory.build_model(xml_fixture('address').element_children.first)}

    it 'should load all address data correctly' do
      subject.should be_a(Address)
      subject.type.should eq :home
      subject.street.should eq 'Karl-Jaspers-Str. 86'
      subject.zip.should eq '71182'
      subject.city.should eq 'Klemensland'
      subject.country.should eq 'Germany'
    end
  end

  describe 'member' do
    subject {Import::MemberFactory.build_model(xml_fixture('member').element_children.first)}
    let(:home_address) { build(:xml_home_address) }
    let(:business_address) { build(:xml_business_address) }

    it 'should load simple member data correctly' do
      subject.should be_a(Member)
      subject.member_id.should eq '027146'
      subject.first_name.should eq 'Angela'
      subject.last_name.should eq 'vom Mrugalla'
      subject.gender.should eq :female
      subject.date_of_birth.should eq Date.new(1988, 11, 12)
      subject.member_since.should eq Date.new(2008, 7, 1)
      subject.languages.sort.should eq [:de, :en, :fr, :it]
    end

    it 'should load embedded member data correctly' do
      subject.addresses.should_not be_empty
      subject.addresses.should have_same_attributes_as([business_address, home_address])
    end
  end
end