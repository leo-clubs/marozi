require 'spec_helper'

describe Import do
  describe Import::OfficeFactory do
    it 'should create mapping correctly' do
      subject = Import::OfficeFactory.new(xml_fixture('office').element_children.first).build_model
      subject.should be_a(Office)
      subject.name.should eq 'DSpr'
      subject.member_id.should eq '027146'
    end
  end
end