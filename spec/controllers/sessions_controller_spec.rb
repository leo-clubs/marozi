require 'spec_helper'

describe SessionsController do
  let(:existing_member_id) {82721}
  let(:existing_club_id) {5931}

  before(:each) do
    session.clear
    m = create(:member, leo_id: existing_member_id)
    m.club = create(:club, leo_id: existing_club_id)
    m.save!
  end

  describe '#create' do
    it 'create the session data correctly' do
      post :create, email_or_id: existing_member_id
      expect(session[:current_user]).to eq(existing_member_id.to_s)
      expect(session[:current_user_club]).to eq(existing_club_id)
    end
  end

  describe '#destroy' do
    it 'destroys session data correctly' do
      expect(session).to be_empty
      post :create, email_or_id: existing_member_id
      expect(session).not_to be_empty
      get :destroy
      expect(session).to be_empty
    end
  end
end