require 'spec_helper'

describe MembersHelper do
  describe '#member_simple_attribute_tablerow' do
    before(:each) do
      @member = build(:simple_member)
    end

    it 'should print table row correct for default values' do
      helper.should_receive(:content_tag).with(:td, { width: '15%' })
      helper.should_receive(:content_tag).with(:td)
      helper.should_receive(:content_tag).with(:tr)
      helper.member_simple_attribute_tablerow(:first_name, 'First Name', 'Enter First Name')
    end
  end

  describe '#member_select_attribute_tablerow' do
    before(:each) do
      @member = build(:simple_member)
    end

    it 'should print table row correct for gender select' do
      helper.should_receive(:content_tag).with(:td, { width: '15%' })
      helper.should_receive(:content_tag).with(:td)
      helper.should_receive(:content_tag).with(:tr)
      helper.member_select_attribute_tablerow(:gender, 'Gender', [[:female, 'Female'],[:male, 'Male']], 'Select gender')
    end
  end
end