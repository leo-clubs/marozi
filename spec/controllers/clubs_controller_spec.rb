require 'spec_helper'

describe ClubsController do
  describe 'index' do
    before(:each) do
      2.times{create :district}
    end

    it 'should build the club hash correctly' do
      get :index
      clubs = assigns(:clubs)
      clubs.keys.should eq %w{KL UV}
      clubs.values.flatten.size.should eq Club.count
    end
  end

  describe 'me' do
    let(:existing_id) {87294}

    it '/clubs/my_club redirects to club of logged in member' do
      member = create(:simple_member, leo_id: existing_id)
      controller.class.skip_before_filter :require_login
      session[:current_user] = existing_id
      get :my_club
      assigns(:club).should eq member.club
    end
  end
end