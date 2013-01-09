require 'spec_helper'

describe Member do
  context 'finders' do
    let(:existing_id) {87294}
    let(:non_existing_id) {987294}

    before(:each) do
      create(:simple_member, leo_id: existing_id)
    end

    it 'should find member for id' do
      m = Member.find_by_member_id existing_id
      m.should_not be_nil
    end

    it 'should not find member non-existing id' do
      m = Member.find_by_member_id non_existing_id
      m.should be_nil
    end
  end

  context 'updates' do
    let(:simple_member) { create(:simple_member) }

    it 'should update nested attributes correctly (model)', skip: true do
      contact_info = simple_member.contact_infos.first
      changed_street = "#{contact_info.street} changed"
      simple_member.update_attributes contact_infos_attributes: {'0' => { id: contact_info.id, street: changed_street }}
      simple_member.reload.contact_infos.first.street.should eq changed_street
    end
  end
end