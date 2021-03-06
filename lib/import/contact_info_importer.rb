# encoding: utf-8
require_relative './helper/helper'

module Import
  class ContactInfoImporter
    include Helper

    def initialize node
      @node = node
    end

    def country_mappings
      {
        'Deutschland' => 'Germany',
        'Adresse unbekannt' => 'Germany',
        'Frankreich' => 'France',
        'Republik Ungarn' => 'Hungary',
        'Österreich' => 'Austria',
        'Schweiz' => 'Switzerland',
        'Dänemark' => 'Denmark',
        'Tschechische Republik' => 'Czech Republik',
        'Niederlande' => 'The Netherlands'
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
       'type' => [:kind],
      }
    end

    def build_model
      a = ::ContactInfo.new

      extract_from_attribute_list list: @node.attributes, mapping: simple_attribute_mappings, entity: a
      extract_from_element_list list: @node.element_children.select{|c| c.children.size == 1}, mapping: simple_element_mappings, entity: a

      ignored = ['id', 'country', 'kind']
      a.attributes.except(*ignored).reject{|k,v| v == nil}.empty? ? nil : a
    end
  end
end