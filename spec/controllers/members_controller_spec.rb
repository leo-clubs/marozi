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

  describe 'me' do
    let(:existing_id) {'087294'}

    it '/members/me redirects to logged in member' do
      member = create(:simple_member, leo_id: existing_id)
      controller.class.skip_before_filter :require_login
      session[:current_user] = existing_id
      get :me
      assigns(:member).should eq member
      assigns(:club).should eq member.club
    end
  end
end