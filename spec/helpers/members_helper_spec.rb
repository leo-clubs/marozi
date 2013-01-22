require 'spec_helper'

describe MembersHelper do

  describe '#name_cell' do
    it 'should print table cell correct for default values' do
      html = helper.name_cell(name: 'Column')
      expect(html).to eq '<td width="15%">Column</td>'
    end
  end

  describe '#value_cell' do
    it 'should print table cell for text field without options' do
      html = helper.value_cell(field: 'field', value: 'value', type: 'text', caption: 'An awesome Field', editable_class: 'editable')
      expect(html).to eq '<td><a class="editable" data-field-title="An awesome Field" data-field-type="text" href="#" id="field">value</a></td>'
    end

    it 'should print table cell for text field with options' do
      html = helper.value_cell(field: 'field', value: 'value', type: 'text', caption: 'An awesome Field', editable_class: 'editable', my_awesome_key: 'my_awesome_value')
      expect(html).to eq '<td><a class="editable" data-field-title="An awesome Field" data-field-type="text" href="#" id="field" my_awesome_key="my_awesome_value">value</a></td>'
    end
  end

  describe '#member_simple_attribute_tablerow' do
    opts = {field: :first_name, value: 'Susanne', name: 'Susanne', caption: 'Enter First Name', type: 'text', editable_class: 'editable'}
    include_context 'members helper', opts

    it 'should print table row correct for default values' do
      html = helper.member_simple_attribute_tablerow(opts.slice(:field, :caption, :name))
      expect(html).to eq '<tr><td></td><td></td></tr>'
    end
  end

  describe '#member_date_attribute_tablerow' do
    opts = {field: :date_of_birth, value: Date.new(1992, 11, 12), name: 'Birthday', caption: 'Please enter your Birthday', type: 'date', editable_class: 'editable', :'data-field-datepicker' => {language: I18n.locale}.to_json}
    include_context 'members helper', opts

    it 'should print table row correct for birth date' do
      html = helper.member_date_attribute_tablerow(opts.slice(:field, :caption, :name))
      expect(html).to eq '<tr><td></td><td></td></tr>'
    end
  end

  describe '#member_select_attribute_tablerow' do
    gender_array = [{value: 'female', text: 'Female'}, {value: 'male', text: 'Male'}]
    opts = {field: :gender, value: :female, name: 'Gender', caption: 'Select Gender', type: 'select', editable_class: 'editable', :'data-field-source' => gender_array.to_json}
    include_context 'members helper', opts

    it 'should print table row correct for gender select' do
      html = helper.member_select_attribute_tablerow(opts.slice(:field, :name, :caption).merge({select_options: [[:female, 'Female'],[:male, 'Male']]}))
      expect(html).to eq '<tr><td></td><td></td></tr>'
    end
  end
end