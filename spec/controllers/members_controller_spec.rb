require 'spec_helper'

describe MembersController do

  include_examples 'variable assignment for members controller', 'show'
  include_examples 'variable assignment for members controller', 'edit'

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

  describe 'update' do
    let(:simple_member) {create(:simple_member)}

    it 'updates attribute correctly' do
      changed_name = "#{simple_member.first_name} changed"
      patch :update, id: simple_member.id, member: { first_name: changed_name}
      Member.find(simple_member.id).first_name.should eq changed_name
    end

    it 'disallows changing of leo_id' do
      expect { patch :update, id: simple_member.id, member: { leo_id: 666 } }.to raise_error(ActionController::UnpermittedParameters)
    end
  end
end