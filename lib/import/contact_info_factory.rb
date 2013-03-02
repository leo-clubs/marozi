# encoding: utf-8
require_relative './helper/mapping_helper'

module Import
  class ContactInfoFactory
    include MappingHelper

    def initialize node
      @node = node
    end

    def country_mappings
      {
        'Deutschland' => 'Germany',
        'Adresse unbekannt' => 'Germany',
        'Frankreich' => 'France',
        'Republik Ungarn' => 'Hungary',
        'Österreich' => 'Austria'
      }
    end

    def simple_element_mappings
      {
       'EMAIL' => [:email_address],
       'STREET' => [:street],
       'ZIP' => [:zip],
       'CITY' => [:city],
       'COUNTRY' => [:country, mapping_lambda(country_mappings, 'Germany')],
       'TEL' => [:phone_number],
       'MOBILE' => [:mobile_phone_number],
       'FAX' => [:fax_number],
       'URL' => [:homepage]
      }
    end

    def simple_attribute_mappings
      {
       'type' => [:type],
      }
    end

    def build_model
      a = ::ContactInfo.new

      extract_from_attribute_list list: @node.attributes, mapping: simple_attribute_mappings, entity: a
      extract_from_element_list list: @node.element_children.select{|c| c.children.size == 1}, mapping: simple_element_mappings, entity: a

      ignored = ['_id', 'country', 'type']
      a.attributes.except(*ignored).empty? ? nil : a
    end
  end
end