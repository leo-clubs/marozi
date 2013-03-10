require 'spec_helper'

describe Import do
  describe Import::OfficeFactory do
    it 'should create mapping correctly' do
      subject = Import::OfficeFactory.new(xml_fixture('office'), '2012-2013').build_model
      expect(subject).to be_a(Office)
      expect(subject.leo_id).to eq 1000
      expect(subject.year).to eq '2012-2013'
      #expect(subject.name).to eq :dspr
      expect(subject.member_id).to eq 27146
    end
  end
end