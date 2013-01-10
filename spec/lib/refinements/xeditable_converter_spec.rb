require 'spec_helper'

using XEditableConverter

describe XEditableConverter do
  it 'should convert simple hash correctly' do
    { 
      'name' => 'first_name',
      'value' => 'Hans',
      'pk' => '93920',
      'authenticity_token' => '1nBva0jogR/92ASHrRG9HIvBXmL6KdxuDfFJH3/CH7o=',
      'id' => '93920'
      }.to_rails_params.should eq first_name: 'Hans'
  end
end