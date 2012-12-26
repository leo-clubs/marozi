require 'spec_helper'

describe District do
  context 'finders' do
    let(:existing_id) {'087294'}
    let(:non_existing_id) {'987294'}

    before(:each) do
      @member = create(:simple_member, leo_id: existing_id)
    end

    after(:each) do
      @member = nil
    end

    it 'should find multiple district for id' do
      m = MultipleDistrict.find_by_member_id existing_id
      m.should eq @member.club.district.multiple_district
    end

    it 'should not find multiple district non-existing id' do
      m = MultipleDistrict.find_by_member_id non_existing_id
      m.should be_nil
    end
  end
end