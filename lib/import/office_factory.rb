require_relative './helper/mapping_helper'

module Import
  class OfficeFactory
    include MappingHelper

    INITIAL_VALUE = 1000
    @@counter = INITIAL_VALUE

    def self.increase_counter
      @@counter += 1
    end

    def self.counter
      @@counter
    end

    def self.reset_counter
      @@counter = INITIAL_VALUE
    end

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
      o.leo_id = self.class.counter
      self.class.increase_counter
      o
    end
  end
end