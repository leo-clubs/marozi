require 'spec_helper'

describe Converters do
  include_context 'module', described_class

  describe '#xeditable_to_rails_params' do
    it 'should convert simple hash correctly' do
      converted_params = dummy_class.xeditable_to_rails_params({
        'name' => 'first_name',
        'value' => 'Hans',
        'pk' => '93920',
        'authenticity_token' => '1nBva0jogR/92ASHrRG9HIvBXmL6KdxuDfFJH3/CH7o=',
        'id' => '93920'
        })
      expect(converted_params).to eq first_name: 'Hans'
    end
  end
end