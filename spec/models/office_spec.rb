require 'spec_helper'

describe Office do
  include_examples 'max_ids', Office, 20

  describe '#member' do
    it 'should return correct member for office' do
      member = create(:president_member)
      office = Office.where(member_id: member.leo_id).first
      expect(office.member).to eq member
    end
  end
end