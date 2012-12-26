require 'spec_helper'

describe Member do
  context 'finders' do
    let(:existing_id) {'087294'}
    let(:non_existing_id) {'987294'}

    before(:each) do
      create(:simple_member, leo_id: existing_id)
    end

    it 'should find member for id' do
      m = Member.find_by_member_id existing_id
      m.should_not be_nil
    end

    it 'should not find member non-existing id' do
      m = Member.find_by_member_id non_existing_id
      m.should be_nil
    end

    it 'should find user by auth_conditions for id' do
      m = Member.find_first_by_auth_conditions login: existing_id
      m.should_not be_nil
    end

    it 'should not find user by auth_conditions for non-existing id' do
      m = Member.find_first_by_auth_conditions login: non_existing_id
      m.should be_nil
    end
  end
end