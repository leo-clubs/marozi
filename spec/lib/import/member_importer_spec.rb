require 'spec_helper'

describe Import do
  describe Import::MemberImporter do
    subject {Import::MemberImporter.new(xml_fixture('member'), '2012-2013').build_model}
    let(:home_contact_info) { build(:xml_home_contact_info) }

    it 'should load simple member data correctly' do
      expect(subject).to be_a(Member)
      expect(subject.oid).to eq 27146
      expect(subject.year).to eq '2012-2013'
      expect(subject.first_name).to eq 'Angela'
      expect(subject.last_name).to eq 'vom Mrugalla'
      expect(subject.gender).to eq :female
      expect(subject.status).to eq :active
      expect(subject.profession).to eq 'Stud. Jur.'
      expect(subject.date_of_birth).to eq Date.new(1988, 11, 12)
      expect(subject.languages.sort).to eq [:deu, :eng, :fra, :ita]
    end

    it 'should load embedded member data correctly' do
      expect(subject.contact_infos).to_not be_empty
      expected_attributes = [home_contact_info.attributes]
      actual_attributes = subject.contact_infos.map{|c| c.attributes}
      expect(actual_attributes).to eq(expected_attributes)
    end
  end
end