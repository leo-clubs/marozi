require 'spec_helper'

describe MembersHelper do

  describe '#name_cell' do
    it 'should print table cell correct for default values' do
      html = helper.name_cell('Column')
      html.should eq '<td width="15%">Column</td>'
    end
  end

  describe '#member_simple_attribute_tablerow' do
    before(:each) do
      @member = build(:simple_member, first_name: 'Susanne')
    end

    it 'should print table row correct for default values' do
      helper.should_receive(:name_cell).with('First Name').and_return(content_tag(:td))
      html = helper.member_simple_attribute_tablerow(:first_name, 'First Name', 'Enter First Name')
      html.should eq '<tr><td></td><td><a class="editable" data-field-title="Enter First Name" data-field-type="text" href="#" id="first_name">Susanne</a></td></tr>'
    end
  end

  describe '#member_select_attribute_tablerow' do
    before(:each) do
      @member = build(:simple_member, gender: 'female')
    end

    it 'should print table row correct for gender select' do
      helper.should_receive(:name_cell).with('Gender').and_return(content_tag(:td))
      html = helper.member_select_attribute_tablerow(:gender, 'Gender', [[:female, 'Female'],[:male, 'Male']], 'Select gender')
      html.should eq '<tr><td></td><td><a class="editable" data-field-source="[{&quot;value&quot;:&quot;female&quot;,&quot;text&quot;:&quot;Female&quot;},{&quot;value&quot;:&quot;male&quot;,&quot;text&quot;:&quot;Male&quot;}]" data-field-title="Select gender" data-field-type="select" href="#" id="gender">female</a></td></tr>'
    end
  end
end