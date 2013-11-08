require_relative './helper/helper'

module Import
  class MemberImporter
    include Helper

    def initialize node, year = nil
      @node = node
      @year = year
    end

    def type_mapping
      {
        'A' => :active,
        'P' => :passive,
        'E' => :honorary,
      }
    end

    def simple_attribute_mappings
      {
        'id' => [:oid, integer_lambda],
        'status' => [:status, mapping_lambda(type_mapping, :active)]
      }
    end

    def simple_element_mappings
      {
        'FIRSTNAME' => [:first_name, text_value_lambda],
        'LASTNAME' => [:last_name, text_value_lambda],
        'TITLE' => [:academic_title, text_value_lambda],
        'BIRTHDATE' => [:date_of_birth,  date_lambda],
        'SEX' => [:gender, gender_lambda],
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
      m = ::Member.new :year => @year

      extract_from_attribute_list list: @node.attributes, mapping: simple_attribute_mappings, entity: m
      extract_from_element_list list: @node.element_children.select{|c| c.children }, mapping: simple_element_mappings, entity: m
      extract_from_element_list list: @node.element_children.select{|c| c.element_children.size >= 1}, mapping: list_element_mappings, entity: m

      m
    end
  end
end