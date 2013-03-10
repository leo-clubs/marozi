require 'spec_helper'

describe Club do
  it_behaves_like 'a hierarchy'
  include_examples 'max_ids', Club, 5

  describe '#offices' do
    it 'should return correct offices for president member' do
      president_member = create(:president_member)
      club = president_member.club
      office = Office.where(member_id: president_member.leo_id).where(parent_id: club.leo_id).first
      expect(club.offices.size).to eq 1
      expect(club.offices).to eq [office]
    end
  end
end