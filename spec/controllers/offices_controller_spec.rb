require 'spec_helper'

describe OfficesController do
  context 'protected methods' do
    include_context 'protected controller'

    describe '#update' do
      it 'should change office correctly' do
        office = create(:president_office)
        new_member_id = office.member_id + 10
        patch :update, id: office.oid, value: new_member_id
        expect(office.reload.member_id).to eq new_member_id
      end
    end
  end
end