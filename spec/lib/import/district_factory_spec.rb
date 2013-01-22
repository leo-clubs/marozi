require 'spec_helper'

describe Import do
  describe Import::DistrictFactory do
    subject {Import::DistrictFactory.new(xml_fixture('district'), '2012-2013').build_model}

    it 'should load all simple district data correctly' do
      expect(subject).to be_a(District)
      expect(subject.leo_id).to eq 66
      expect(subject.year).to eq '2012-2013'
      expect(subject.name).to eq 'KL'
    end

    it 'should load club data correctly' do
       expect(subject.clubs).to_not be_empty
       expect(subject.clubs.size).to be 4
    end

    it 'should load office data correctly' do
      expect(subject.offices).to_not be_empty
      expect(subject.offices.size).to be 7
    end
  end
end