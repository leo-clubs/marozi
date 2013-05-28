require 'spec_helper'

describe Club do
  it_behaves_like 'a hierarchy'

  describe '#offices' do
    it 'should return correct offices for president member' do
      president_member = create(:president_member)
      club = president_member.club
      office = Office.where(member_id: president_member.oid).where(parent_id: club.oid).first
      expect(club.offices.size).to eq 1
      expect(club.offices).to eq [office]
    end
  end
end