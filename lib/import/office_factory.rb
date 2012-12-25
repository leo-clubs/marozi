require_relative './helper/mapping_helper'

module Import
  class OfficeFactory
    include MappingHelper

    def initialize node, year = nil
      @node = node
      @year ||= 2012
    end

    def simple_element_mappings
      {
       'PERSON' => [:member_id, office_to_member_lambda],
       'NAME' => [:name]
      }
    end

    def build_model
      o = ::Office.new
      extract_from_element_list list: @node.element_children, mapping: simple_element_mappings, entity: o
      o
    end
  end
end