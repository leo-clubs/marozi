require 'spec_helper'

describe Office do
  describe '#member' do
    it 'should return correct member for office' do
      member = create(:president_member)
      office = Office.where(member_id: member.oid).first
      expect(office.member).to eq member
    end
  end
end