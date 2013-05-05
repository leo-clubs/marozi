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

    describe '#my_club' do
      let(:existing_id) { 87294 }

      it 'should redirects to club of logged in member' do
        member = create(:simple_member, oid: existing_id)
        session[:current_user] = existing_id
        get :my_club
        expect(assigns(:club)).to eq member.club
      end
    end

    describe '#members' do
      let(:club) { create :club_with_members }
      let(:members) { club.members }

      it 'should correctly converted JSON array' do
        get :members, id: club.oid, type: :xeditable_names_only
        expect(response.content_type).to eq 'application/json'
        ids = JSON.parse(response.body).map{|p| p['value']}
        expect(ids).to match_array(members.map{|p| p.oid})
      end
    end

    describe '#show' do
      let(:club) { create :club_with_members }

      it 'should correctly converted JSON array' do
        get :show, id: club.oid
        expect(assigns(:club)).to eq club
      end
    end
  end
end