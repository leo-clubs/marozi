require 'spec_helper'

describe Club do
  it_behaves_like 'a hierarchy'
  include_examples 'max_ids', Club, 5

  describe '#offices' do
    it 'should return correct hash for simple offices' do
      president_member = create(:president_member)
      club = president_member.club
      office = create(:president, parent_id: club.leo_id, member_id: president_member.leo_id)
      expect(club.offices).to eq [office]
    end
  end
end