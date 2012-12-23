module Import

  module MappingHelper
    extend self

    locale_lambda = lambda do |v|
      base_lang = [:de]
      begin
        additional_langs = v.xpath('//NAME/text()').map{|e| e.text.to_sym}
      rescue
        additional_langs = []
      end
      (base_lang + additional_langs).sort
    end

    def date_lambda
      lambda {|v| Date.parse(v)}
    end

    def text_value_lambda
      lambda {|v| v.text}
    end

    def locale_lambda
      lambda do |v|
        base_lang = [:de]
        begin
          additional_langs = v.xpath('//NAME/text()').map{|e| e.text.to_sym}
        rescue
          additional_langs = []
        end
        (base_lang + additional_langs).sort
      end
    end

    def country_lambda mapping
      lambda {|v| mapping[v] || 'Germany'}
    end

    def gender_lambda
      lambda {|v| v.text.strip == 'M' ? :male : :female }
    end

    def extract_from_attribute_list opts
      opts[:list].each do |a|
        according_value = opts[:mapping][a[0]]
        if according_value
          value = according_value[1].class == Proc ? according_value[1].call(a[1].value) : a[1].value
          opts[:entity].send("#{according_value[0]}=", value)
        end
      end
    end

    def extract_from_element_list opts
      opts[:list].each do |n|
        according_value = opts[:mapping][n.name]
        if according_value
          value = according_value[1].class == Proc ? according_value[1].call(n) : n.text
          opts[:entity].send("#{according_value[0]}=", value)
        end
      end
    end
  end


  module MemberFactory
    extend self
    extend MappingHelper

    def simple_attribute_mappings
      {
       'membershipStart' => [:member_since, date_lambda],
       'id' => [:member_id, nil],
      }
    end

    def simple_element_mappings
      {
       'FIRSTNAME' => [:first_name, text_value_lambda ],
       'LASTNAME' => [:last_name, text_value_lambda ],
       'BIRTHDATE' => [:date_of_birth,  date_lambda],
       'SEX' => [:gender, gender_lambda ]
      }
    end

    def list_element_mappings
      {
      'LANGUAGES' => [:languages, locale_lambda]
      }
    end

    def build_model node
      m = ::Member.new

      extract_from_attribute_list list: node.attributes, mapping: simple_attribute_mappings, entity: m
      extract_from_element_list list: node.element_children.select{|c| c.children.size == 1}, mapping: simple_element_mappings, entity: m
      extract_from_element_list list: node.element_children.select{|c| c.element_children.size > 1}, mapping: list_element_mappings, entity: m

      m
    end
  end

  module AddressFactory
    extend self
    extend MappingHelper

    def country_mappings
      {
        'Deutschland' => 'Germany',
        'Frankreich' => 'France',
        'Republik Ungarn' => 'Hungary',
        'Österreich' => 'Austria'
      }
    end

    def simple_element_mappings
      {
       'STREET' => [:street,  nil],
       'ZIP' => [:zip, nil ],
       'CITY' => [:city, nil ],
       'COUNTRY' => [:country,  country_lambda(country_mappings)]
      }
    end

    def simple_attribute_mappings
      {
       'type' => [:type, nil],
      }
    end

    def build_model node
      a = ::Address.new

      extract_from_attribute_list list: node.attributes, mapping: simple_attribute_mappings, entity: a
      extract_from_element_list list: node.element_children.select{|c| c.children.size == 1}, mapping: simple_element_mappings, entity: a

      a
    end
  end
end