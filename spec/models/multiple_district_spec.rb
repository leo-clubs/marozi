require 'spec_helper'

describe MultipleDistrict do
  it_behaves_like 'a hierarchy', 3

  describe '#create_committees' do
    it 'should create an IT committee' do
      committee_type = :it
      appointee_type = :"#{committee_type}_appointee"
      md = create(:multiple_districts_with_it_office)
      expect{md.create_committees(committee_type)}.to change{Committee.count}.by(1)
      committee = Committee.where(kind: committee_type).first
      expect(committee.chairperson_id).to eq(md.offices.where(name: appointee_type).first.member_id)
    end

    it 'should not create already existing committee' do
      committee_type = :it
      create(:committee, kind: committee_type)
      md = create(:multiple_districts_with_it_office)
      expect{md.create_committees(committee_type)}.not_to change{Committee.count}
    end
  end

  describe '#setting' do
    it 'should query the correct setting' do
      md = create(:multiple_district_with_setting)
      expect(md.settings).not_to be_nil
    end

    it 'should set the correct setting' do
      md = create(:multiple_district)
      s = create(:setting)
      md.add_setting s
      s.reload
      expect(s.multiple_district).to eq(md.oid)
    end
  end
end