require 'spec_helper'

describe Import  do
  describe Import::ContactInfoFactory do
    let(:german_address) {Import::ContactInfoFactory.new(xml_fixture('german_address')).build_model}
    let(:non_german_address) {Import::ContactInfoFactory.new(xml_fixture('non_german_address')).build_model}

    it 'should load all contact_info data correctly' do
      expect(german_address).to be_a(ContactInfo)
      expect(german_address.type).to eq :home
      expect(german_address.street).to eq 'Karl-Jaspers-Str. 86'
      expect(german_address.zip).to eq '71182'
      expect(german_address.city).to eq 'Klemensland'
      expect(german_address.country).to eq 'Germany'
    end

    it 'should load all contact_info data correctly for address outside of Germany' do
      expect(non_german_address).to be_a(ContactInfo)
      expect(non_german_address.type).to eq :home
      expect(non_german_address.street).to eq '19 Rue Beaubourg'
      expect(non_german_address.zip).to eq '75004'
      expect(non_german_address.city).to eq 'Paris'
      expect(non_german_address.country).to eq 'France'
    end
  end
end