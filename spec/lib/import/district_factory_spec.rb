require 'spec_helper'

describe Import do
  describe Import::DistrictFactory do
    subject {Import::DistrictFactory.new(xml_fixture('district'), '2012-2013').build_model}

    it 'should load all simple district data correctly' do
      subject.should be_a(District)
      subject.leo_id.should eq 66
      subject.year.should eq '2012-2013'
      subject.name.should eq 'KL'
    end

    it 'should load club data correctly' do
       subject.clubs.should_not be_empty
       subject.clubs.size.should be 4
    end

    it 'should load office data correctly' do
      subject.offices.should_not be_empty
      subject.offices.size.should be 7
    end
  end
end