require 'spec_helper'

describe Club do
  context 'finders' do
    let(:existing_id) {'087294'}
    let(:non_existing_id) {'987294'}

    before(:each) do
      @member = create(:simple_member, leo_id: existing_id)
    end

    after(:each) do
      @member = nil
    end

    it 'should find club for id' do
      c = Club.find_by_member_id existing_id
      c.should eq @member.club
    end

    it 'should not find user non-existing id' do
      c = Club.find_by_member_id non_existing_id
      c.should be_nil
    end
  end
end