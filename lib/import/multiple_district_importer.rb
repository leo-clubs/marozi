require_relative './helper/helper'

module Import
  class MultipleDistrictImporter
    include Helper

    def initialize node, year = nil
      @node = node
      @year = year
    end

    def md_mappings
      {
        'Leo Clubs Deutschland' => '111'
      }
    end

    def simple_attribute_mappings
      {
        'id' => [:leo_id, integer_lambda],
        'name' => [:name, mapping_lambda(md_mappings, '0')],
      }
    end

    def list_element_mappings
      {
        'DISTRICTS' => [:districts, district_lambda(@year)],
        'OFFICERS' => [:offices, office_lambda(@year)]
      }
    end

    def build_model
      d = ::MultipleDistrict.new :year => @year

      extract_from_attribute_list list: @node.attributes, mapping: simple_attribute_mappings, entity: d
      extract_from_element_list list: @node.element_children.select{|c| c.element_children.size >= 1}, mapping: list_element_mappings, entity: d

      d
    end
  end
end