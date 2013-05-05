require 'spec_helper'

describe MembersController do
  context 'protected methods' do
    include_context 'protected controller'

    include_examples 'member finders', 'show'
    include_examples 'member finders', 'me', 87294

    describe '#update' do
      let(:simple_member) {create(:simple_member)}

      it 'updates attribute correctly' do
        changed_name = "#{simple_member.first_name} changed"
        patch :update, id: simple_member.oid, 'name' => 'first_name', 'value' => changed_name, 'pk' => simple_member.oid
        expect(Member.find(simple_member.id).first_name).to eq changed_name
      end

      it 'updates nested attribute correctly', skip: true  do
        contact_info = simple_member.contact_infos.first
        changed_street = "#{contact_info.street} changed"
        patch :update, id: simple_member.oid, contact_infos_attributes: {'0' => { id: contact_info.id, street: changed_street }}
        expect(Member.find(simple_member.id).contact_infos.first.street).to eq changed_street
      end

      it 'disallows changing of oid' do
        unchanged_id = simple_member.oid
        patch :update, id: simple_member.oid, 'name' => 'oid', 'value' => unchanged_id + 1, 'pk' => simple_member.oid
        expect(Member.find(simple_member.id).oid).to eq unchanged_id
      end
    end

    describe '#create' do
      it 'creates member correctly' do
        expect{post(:create, first_name: 'Hans', last_name: 'Peter')}.to change{Member.count}.by(1)
      end
    end
  end
end