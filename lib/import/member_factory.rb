require_relative './helper/mapping_helper'

module Import
  class MemberFactory
    include MappingHelper

    def initialize node, year = nil
      @node = node
      @year ||= 2012
    end

    def simple_attribute_mappings
      {
        'membershipStart' => [:member_since, date_lambda],
        'id' => [:leo_id],
      }
    end

    def simple_element_mappings
      {
        'FIRSTNAME' => [:first_name, text_value_lambda ],
        'LASTNAME' => [:last_name, text_value_lambda ],
        'BIRTHDATE' => [:date_of_birth,  date_lambda],
        'SEX' => [:gender, gender_lambda ],
        'PROFESSION' => [:profession, profession_lambda]
      }
    end

    def list_element_mappings
      {
        'LANGUAGES' => [:languages, locale_lambda],
        'ADDRESSES' => [:contact_infos, contact_info_lambda]
      }
    end

    def build_model
      m = ::Member.new

      extract_from_attribute_list list: @node.attributes, mapping: simple_attribute_mappings, entity: m
      extract_from_element_list list: @node.element_children.select{|c| c.children }, mapping: simple_element_mappings, entity: m
      extract_from_element_list list: @node.element_children.select{|c| c.element_children.size >= 1}, mapping: list_element_mappings, entity: m

      m
    end
  end
end