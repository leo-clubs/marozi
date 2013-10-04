require 'spec_helper'

describe Member do
  it_behaves_like 'a hierarchy'

  context 'finders' do
    let(:existing_id) {87294}
    let(:non_existing_id) {987294}

    before(:each) do
      create(:simple_member, oid: existing_id)
    end

    it 'should find member for id' do
      m = Member.find_by_member_id existing_id
      expect(m).to_not be_nil
    end

    it 'should not find member non-existing id' do
      m = Member.find_by_member_id non_existing_id
      expect(m).to be_nil
    end
  end

  context 'updates' do
    let(:simple_member) { create(:simple_member) }

    it 'should update nested attributes correctly (model)', skip: true do
      contact_info = simple_member.contact_infos.first
      changed_street = "#{contact_info.street} changed"
      simple_member.update_attributes contact_infos_attributes: {'0' => { id: contact_info.id, street: changed_street }}
      expect(simple_member.reload.contact_infos.first.street).to eq changed_street
    end
  end

  context 'dynamic attributes' do
    let(:simple_member) { create(:simple_member, academic_title: 'Dr. jur.') }

    it 'should calculate title correctly' do
      expect(simple_member.title).to eq('Dr.')
    end
  end
end