require 'spec_helper'

describe 'import'  do
  describe 'member' do
    let(:member) {xml_fixture('member').element_children.first}

    it 'should load simple member data correctly' do
      m = Import::MemberFactory.build_model member
      m.should be_a(Member)
      m.first_name.should eq 'Angela'
      m.last_name.should eq 'vom Mrugalla'
      m.date_of_birth.should eq Date.new(1988, 11, 12)
      m.member_since.should eq Date.new(2008, 7, 1)
      m.languages.sort.should eq [:de, :en, :fr, :it]
    end
  end
end