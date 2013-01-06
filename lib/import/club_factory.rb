require_relative './helper/mapping_helper'

module Import
  class ClubFactory
    include MappingHelper

    def initialize node, year = nil
      @node = node
      @year = year
    end

    def simple_attribute_mappings
      {
        'id' => [:leo_id, integer_lambda],
      }
    end

    def list_element_mappings
      {
        'MEMBERS' => [:members, member_lambda(@year)],
        'OFFICERS' => [:offices, office_lambda(@year)]
      }
    end

    def simple_element_mappings
      {
        'NAME' => [:name],
        'FOUNDDATE' => [:founded_at, date_lambda ],
        'CHARTERDATE' => [:chartered_at, date_lambda ],
        'GODFATHER' => [:godfather],
        'MEET' => [:meet_description],
        'BANK' => [:bank],
        'URL' => [:homepage]
      }
    end

    def build_model
      c = ::Club.new :year => @year

      extract_from_attribute_list list: @node.attributes, mapping: simple_attribute_mappings, entity: c
      extract_from_element_list list: @node.element_children.select{|c| c.children.size == 1}, mapping: simple_element_mappings, entity: c
      extract_from_element_list list: @node.element_children.select{|c| c.element_children.size >= 1}, mapping: list_element_mappings, entity: c

      c
    end

  end
end