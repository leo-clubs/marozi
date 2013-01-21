require 'spec_helper'

describe Import  do
  describe Import::ContactInfoFactory do
    subject {Import::ContactInfoFactory.new(xml_fixture('address')).build_model}

    it 'should load all contact_info data correctly' do
      expect(subject).to be_a(ContactInfo)
      expect(subject.type).to eq :home
      expect(subject.street).to eq 'Karl-Jaspers-Str. 86'
      expect(subject.zip).to eq '71182'
      expect(subject.city).to eq 'Klemensland'
      expect(subject.country).to eq 'Germany'
    end
  end
end