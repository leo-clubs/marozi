require 'spec_helper'

describe Import do
  describe Import::MultipleDistrictImporter do
    subject {Import::MultipleDistrictImporter.new(xml_fixture('multiple_district'), '2012-2013').build_model}

    it 'should load all simple multiple district data correctly' do
      expect(subject).to be_a(MultipleDistrict)
      expect(subject.leo_id).to eq 42
      expect(subject.year).to eq '2012-2013'
      expect(subject.name).to eq '111'
    end

    it 'should load club data correctly' do
       expect(subject.districts).to_not be_empty
       expect(subject.districts.size).to be 1
    end

    it 'should load office data correctly' do
      expect(subject.offices).to_not be_empty
      expect(subject.offices.size).to be 5
    end
  end
end