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

    it 'updates nested attribute correctly (controller)', skip: true  do
      contact_info = simple_member.contact_infos.first
      changed_street = "#{contact_info.street} changed"
      patch :update, id: simple_member.id, member: { contact_infos_attributes: {'0' => { id: contact_info.id, street: changed_street }}}
      Member.find(simple_member.id).contact_infos.first.street.should eq changed_street
    end

    it 'disallows changing of leo_id' do
      unchanged_id = simple_member.leo_id
      patch :update, id: simple_member.id, member: { leo_id: unchanged_id + 1 }
      Member.find(simple_member.id).leo_id.should eq unchanged_id
    end
  end
end