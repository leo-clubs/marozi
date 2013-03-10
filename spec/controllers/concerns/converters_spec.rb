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

  describe '#person_array_to_xeditable' do
    let(:input_params) {
      [
        OpenStruct.new(leo_id: 1704, first_name: 'Dieter', last_name: 'Müller'),
        OpenStruct.new(leo_id: 1705, first_name: 'Susanne', last_name: 'Schmidt'),
        OpenStruct.new(leo_id: 1706, first_name: 'Peter', last_name: 'Parker'),
        OpenStruct.new(leo_id: 1707, first_name: 'Louis', last_name: 'Lane'),
        OpenStruct.new(leo_id: 1708, first_name: 'John', last_name: 'Doe'),
        OpenStruct.new(leo_id: 1709, first_name: 'Poison', last_name: 'Ivy')
      ]
    }

    it 'should convert person correctly without operation' do
      expected_output = [
        { value: input_params[0].leo_id, text: input_params[0]},
        { value: input_params[1].leo_id, text: input_params[1]},
        { value: input_params[2].leo_id, text: input_params[2]},
        { value: input_params[3].leo_id, text: input_params[3]},
        { value: input_params[4].leo_id, text: input_params[4]},
        { value: input_params[5].leo_id, text: input_params[5]}
      ]
      expect(dummy_class.person_array_to_xeditable(input_params)).to eq expected_output
    end

    it 'should convert person correctly with operation' do
      expected_output = [
        { value: input_params[0].leo_id, text: "#{input_params[0].last_name}, #{input_params[0].first_name}"},
        { value: input_params[1].leo_id, text: "#{input_params[1].last_name}, #{input_params[1].first_name}"},
        { value: input_params[2].leo_id, text: "#{input_params[2].last_name}, #{input_params[2].first_name}"},
        { value: input_params[3].leo_id, text: "#{input_params[3].last_name}, #{input_params[3].first_name}"},
        { value: input_params[4].leo_id, text: "#{input_params[4].last_name}, #{input_params[4].first_name}"},
        { value: input_params[5].leo_id, text: "#{input_params[5].last_name}, #{input_params[5].first_name}"}
      ]
      expect(dummy_class.person_array_to_xeditable(input_params, lambda{|p| "#{p.last_name}, #{p.first_name}"})).to eq expected_output
    end
  end
end