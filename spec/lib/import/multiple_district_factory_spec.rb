require 'spec_helper'

describe Import do
  describe Import::MultipleDistrictFactory do
    subject {Import::MultipleDistrictFactory.new(xml_fixture('multiple_district'), '2012-2013').build_model}

    it 'should load all simple multiple district data correctly' do
      subject.should be_a(MultipleDistrict)
      subject.leo_id.should eq 42
      subject.year.should eq '2012-2013'
      subject.name.should eq '111'
    end

    it 'should load club data correctly' do
       subject.districts.should_not be_empty
       subject.districts.size.should be 1
    end

    it 'should load office data correctly' do
      subject.offices.should_not be_empty
      subject.offices.size.should be 5
    end
  end
end