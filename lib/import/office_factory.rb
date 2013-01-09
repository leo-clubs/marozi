require_relative './helper/mapping_helper'

module Import
  class OfficeFactory
    include MappingHelper

    def initialize node, year
      @node = node
      @year = year
    end

    def simple_attribute_mappings
      {
        'id' => [:leo_id, integer_lambda],
      }
    end

    def simple_element_mappings
      {
       'PERSON' => [:member_id, office_to_member_lambda],
       'NAME' => [:name, office_name_lambda]
      }
    end

    def build_model
      o = ::Office.new year: @year
      extract_from_attribute_list list: @node.attributes, mapping: simple_attribute_mappings, entity: o
      extract_from_element_list list: @node.element_children, mapping: simple_element_mappings, entity: o
      o
    end
  end
end