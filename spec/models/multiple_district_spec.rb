require 'spec_helper'

describe MultipleDistrict do
  it_behaves_like 'a hierarchy', 3
  include_examples 'max_ids', MultipleDistrict, 1

  describe '#create_committees' do
    it 'should create an IT committee' do
      committee_type = :it
      appointee_type = :"#{committee_type}_appointee"
      md = create(:multiple_districts_with_it_office)
      expect{md.create_committees(committee_type)}.to change{Committee.count}.by(1)
      committee = Committee.where(type: committee_type).first
      expect(committee.chairperson_id).to eq(md.offices.where(name: appointee_type).first.member_id)
    end

    it 'should not create already existing committee' do
      committee_type = :it
      create(:committee, type: committee_type)
      md = create(:multiple_districts_with_it_office)
      expect{md.create_committees(committee_type)}.not_to change{Committee.count}
    end
  end
end