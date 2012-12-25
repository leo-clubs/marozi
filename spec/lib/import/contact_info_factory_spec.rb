require 'spec_helper'

describe Import  do
  describe Import::ContactInfoFactory do
    subject {Import::ContactInfoFactory.new(xml_fixture('address')).build_model}

    it 'should load all contact_info data correctly' do
      subject.should be_a(ContactInfo)
      subject.type.should eq :home
      subject.street.should eq 'Karl-Jaspers-Str. 86'
      subject.zip.should eq '71182'
      subject.city.should eq 'Klemensland'
      subject.country.should eq 'Germany'
    end
  end
end