require 'spec_helper'

describe Member do
  context 'authentication' do
    let(:existing_id) {'087294'}
    let(:non_existing_id) {'987294'}
    
    before(:each) do
      create(:simple_member, leo_id: existing_id)
    end

    it 'should find user for id' do
      m = Member.find_first_by_auth_conditions login: existing_id
      m.should_not be_nil
    end

    it 'should not find user for non-existing id' do
      m = Member.find_first_by_auth_conditions login: non_existing_id
      m.should be_nil
    end
  end
end