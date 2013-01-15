require 'spec_helper'

describe MembersHelper do

  describe '#name_cell' do
    it 'should print table cell correct for default values' do
      html = helper.name_cell('Column')
      html.should eq '<td width="15%">Column</td>'
    end
  end

  describe '#member_simple_attribute_tablerow' do
    include_context 'members helper', :first_name, 'Susanne', 'First Name', 'Enter First Name'

    it 'should print table row correct for default values' do
      html = helper.member_simple_attribute_tablerow(field, title, caption)
      html.should eq %Q{
        <tr>
          <td></td>
          <td>
            <a class="editable" data-field-title="#{caption}" data-field-type="text" href="#" id="#{field}">#{value}</a>
          </td>
        </tr>}.strip.gsub(/\>\s+</, '><')
    end
  end

  describe '#member_date_attribute_tablerow', skip: true do
    include_context 'members helper', :date_of_birth, Date.new(1992, 11, 12), 'Birthday', 'Please enter your Birthday'

    it 'should print table row correct for birth date' do
      html = helper.member_date_attribute_tablerow(field, title, caption)
      html.should eq %Q{
        <tr>
          <td></td>
          <td><a class="editable" data-field-title="#{caption}" data-field-type="date" href="#" id="#{field}">#{value}</a></td>
        </tr>}.strip.gsub(/\>\s+</, '><')
    end
  end

  describe '#member_select_attribute_tablerow' do
    include_context 'members helper', :gender, 'female', 'Gender', 'Select Gender'

    it 'should print table row correct for gender select' do
      html = helper.member_select_attribute_tablerow(:gender, 'Gender', [[:female, 'Female'],[:male, 'Male']], caption)
      html.should eq %Q{
        <tr>
          <td></td>
          <td><a class="editable" data-field-source="[{&quot;value&quot;:&quot;female&quot;,&quot;text&quot;:&quot;Female&quot;},{&quot;value&quot;:&quot;male&quot;,&quot;text&quot;:&quot;Male&quot;}]" data-field-title="#{caption}" data-field-type="select" href="#" id="#{field}">#{value}</a></td>
        </tr>}.strip.gsub(/\>\s+</, '><')
    end
  end
end