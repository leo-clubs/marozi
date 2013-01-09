require 'spec_helper'

describe Import do
  describe Import::OfficeFactory do
    it 'should create mapping correctly' do
      subject = Import::OfficeFactory.new(xml_fixture('office'), '2012-2013').build_model
      subject.should be_a(Office)
      subject.leo_id.should eq 1771
      subject.year.should eq '2012-2013'
      subject.name.should eq :dspr
      subject.member_id.should eq 27146
    end
  end
end