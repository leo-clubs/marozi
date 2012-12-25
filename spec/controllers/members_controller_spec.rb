require 'spec_helper'

describe MembersController do
  describe 'show' do
    it 'should assign variables correctly' do
      member = create(:simple_member)
      get :show, id: member.leo_id
      assigns(:member).should eq member
      assigns(:club).should eq member.club
    end
  end
end