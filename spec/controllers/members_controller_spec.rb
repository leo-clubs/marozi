require 'spec_helper'

describe MembersController do

  include_examples 'variable assignment for members controller', :show
  include_examples 'variable assignment for members controller', :edit

  describe 'me' do
    let(:existing_id) { 87294 }

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