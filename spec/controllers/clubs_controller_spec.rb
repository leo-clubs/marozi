require 'spec_helper'

describe ClubsController do
  context 'protected methods' do
    include_context 'protected controller'

    describe '#index' do
      before(:each) do
        2.times{create :district}
      end

      it 'should build the club hash correctly' do
        get :index
        clubs = assigns(:clubs)
        expect(clubs.keys).to eq %w{KL UV}
        expect(clubs.values.flatten.size).to eq Club.count
      end
    end

    describe '#me' do
      let(:existing_id) { 87294 }

      it '/clubs/my_club redirects to club of logged in member' do
        member = create(:simple_member, leo_id: existing_id)
        session[:current_user] = existing_id
        get :my_club
        expect(assigns(:club)).to eq member.club
      end
    end
  end
end