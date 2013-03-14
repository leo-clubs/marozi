require 'spec_helper'

describe XeditableCellHelper do
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

    it 'should print empty link for nil value' do
      html = helper.value_cell(field: 'field', value: nil, type: 'text', caption: 'An awesome Field', editable_class: 'editable', my_awesome_key: 'my_awesome_value')
      expect(html).to eq '<td><a class="editable" data-field-title="An awesome Field" data-field-type="text" href="#" id="field" my_awesome_key="my_awesome_value"></a></td>'
    end

    it 'should print empty link for no value' do
      html = helper.value_cell(field: 'field', type: 'text', caption: 'An awesome Field', editable_class: 'editable', my_awesome_key: 'my_awesome_value')
      expect(html).to eq '<td><a class="editable" data-field-title="An awesome Field" data-field-type="text" href="#" id="field" my_awesome_key="my_awesome_value"></a></td>'
    end
  end

  describe '#i18n_date_format_to_xeditable_date_format' do
    it 'converts international short date format correctly' do
      expect(helper.i18n_date_format_to_xeditable_date_format('%Y-%m-%d')).to eq 'yyyy-mm-dd'
    end

  it 'converts german short date format correctly' do
      expect(helper.i18n_date_format_to_xeditable_date_format('%Y.%m.%d')).to eq 'yyyy.mm.dd'
    end
  end
end