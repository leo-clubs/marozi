require 'spec_helper'

describe MembersHelper do

  describe '#name_cell' do
    it 'should print table cell correct for default values' do
      html = helper.name_cell('Column')
      html.should eq '<td width="15%">Column</td>'
    end
  end

  describe '#member_simple_attribute_tablerow' do
    include_context 'members helper', :first_name, 'Susanne', 'First Name', 'Enter First Name', 'text'

    it 'should print table row correct for default values' do
      html = helper.member_simple_attribute_tablerow(field, name, title)
      html.should eq '<tr><td></td><td></td></tr>'
    end
  end

  describe '#member_date_attribute_tablerow', skip: true do
    include_context 'members helper', :date_of_birth, Date.new(1992, 11, 12), 'Birthday', 'Please enter your Birthday'

    it 'should print table row correct for birth date' do
      html = helper.member_date_attribute_tablerow(field, name, title)
      html.should eq '<tr><td></td><td></td></tr>'
    end
  end

  describe '#member_select_attribute_tablerow' do
    gender_array = [{value: 'female', text: 'Female'}, {value: 'male', text: 'Male'}]
    include_context 'members helper', :gender, 'female', 'Gender', 'Select Gender', 'select', :'data-field-source' => gender_array.to_json

    it 'should print table row correct for gender select' do
      html = helper.member_select_attribute_tablerow(field, name, [[:female, 'Female'],[:male, 'Male']], title)
      html.should eq '<tr><td></td><td></td></tr>'
    end
  end
end