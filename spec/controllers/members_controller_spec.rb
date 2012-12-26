require 'spec_helper'

describe MembersController do
  describe 'routing' do
    let(:existing_id) {'087294'}

    it '/members/me redirects to logged in member' do
      controller.class.skip_before_filter :require_login
      session[:current_user] = existing_id
      get :me
      response.should redirect_to member_path id: existing_id
    end
  end

  describe 'show' do
    it 'should assign variables correctly' do
      member = create(:simple_member)
      get :show, id: member.leo_id
      assigns(:member).should eq member
      assigns(:club).should eq member.club
    end
  end
end