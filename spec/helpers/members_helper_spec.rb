require 'spec_helper'

describe MembersHelper do
  describe '#member_simple_attribute_tablerow' do
    opts = {field: :first_name, value: 'Susanne', name: 'Susanne', caption: 'Enter First Name', type: 'text', editable_class: 'editable'}
    include_context 'members helper', opts

    it 'should print table row correct for default values' do
      html = helper.member_simple_attribute_tablerow(opts.slice(:field, :caption, :name))
      expect(html).to eq '<tr><td></td><td></td></tr>'
    end
  end

  describe '#member_date_attribute_tablerow' do
    opts = {
      field: :date_of_birth,
      value: '1992-11-12',
      type: 'date',
      caption: 'Please enter your Birthday',
      name: 'Birthday',
      editable_class: 'editable',
      :'data-value' => '1992-11-12',
      :'data-format' => 'yyyy-mm-dd',
      :'data-viewformat' => 'yyyy-mm-dd',
      :'data-field-datepicker' => {language: I18n.locale}.to_json,
    }

    before(:each) do
      helper.should_receive(:i18n_date_format_to_xeditable_date_format).any_number_of_times.and_return('yyyy-mm-dd')
      helper.should_receive(:date_value_from_member).any_number_of_times.and_return('1992-11-12')
    end

    include_context 'members helper', opts

    it 'should print table row correct for birth date' do
      html = helper.member_date_attribute_tablerow(opts.slice(:field, :caption, :name))
      expect(html).to eq '<tr><td></td><td></td></tr>'
    end
  end

  describe '#member_select_attribute_tablerow' do
    context 'gender select' do
      gender_array = [{value: 'female', text: 'Female'}, {value: 'male', text: 'Male'}]
      opts = {field: :gender, value: :female, name: 'Gender', caption: 'Select Gender', type: 'select', selected: :female, editable_class: 'editable', :'data-field-source' => gender_array.to_json}
      include_context 'members helper', opts

      it 'should print table row correct for gender select' do
        html = helper.member_select_attribute_tablerow(opts.slice(:field, :name, :caption).merge({select_options: [[:female, 'Female'],[:male, 'Male']]}))
        expect(html).to eq '<tr><td></td><td></td></tr>'
      end
    end
  end

  describe '#member_gender_select_attribute_tablerow' do
    it 'should corectly pass attributes to underlying select helper' do
      helper.should_receive(:member_select_attribute_tablerow).with(hash_including(field: :gender))
      helper.member_gender_select_attribute_tablerow
    end
  end
end