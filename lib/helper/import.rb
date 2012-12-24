module Import

  module MappingHelper
    extend self

    def date_lambda
      lambda do |v|
        begin
          Date.parse(v)
        rescue
          puts "Not a valid date: #{v.inspect}"
          nil
        end
      end
    end

    def text_value_lambda
      lambda {|v| v.text}
    end

    def profession_lambda
      lambda {|v| v.xpath('.//DESCRIPTION/text()').first.text rescue nil}
    end

    def locale_lambda
      lambda do |v|
        base_lang = [:de]
        begin
          additional_langs = v.xpath('.//NAME/text()').map{|e| e.text.to_sym}
        rescue
          additional_langs = []
        end
        (base_lang + additional_langs).uniq.sort
      end
    end

    def contact_info_lambda
      lambda do |v|
        contact_infos = []
        v.xpath('.//ADDRESS').each do |a|
          contact_info = ContactInfoFactory.build_model(a)
          contact_infos << contact_info if contact_info
        end
        contact_infos.sort{|a,b| a.type <=> b.type}
      end
    end

    def member_lambda
      lambda do |v|
        members = []
        v.xpath('.//MEMBER').each do |m|
          members << MemberFactory.build_model(m)
        end
        members
      end
    end

    def country_lambda mapping
      lambda {|v| mapping[v] || 'Germany'}
    end

    def gender_lambda
      lambda {|v| v.text.strip == 'M' ? :male : :female }
    end

    def extract_from_attribute_list opts
      opts[:list].each do |id, attribute|
        according_value = opts[:mapping][id]
        if according_value
          value = according_value[1].class == Proc ? according_value[1].call(attribute.value) : attribute.value
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

  module ClubFactory
    extend self
    extend MappingHelper

    def simple_attribute_mappings
      {
        'id' => [:leo_id],
      }
    end

    def list_element_mappings
      {
        'MEMBERS' => [:members, member_lambda],
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

    def build_model node, save=false
      c = ::Club.new

      extract_from_attribute_list list: node.attributes, mapping: simple_attribute_mappings, entity: c
      extract_from_element_list list: node.element_children.select{|c| c.children.size == 1}, mapping: simple_element_mappings, entity: c
      extract_from_element_list list: node.element_children.select{|c| c.element_children.size >= 1}, mapping: list_element_mappings, entity: c

      c.save! if save
      c
    end

  end


  module MemberFactory
    extend self
    extend MappingHelper

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

    def build_model node
      m = ::Member.new

      extract_from_attribute_list list: node.attributes, mapping: simple_attribute_mappings, entity: m
      extract_from_element_list list: node.element_children.select{|c| c.children }, mapping: simple_element_mappings, entity: m
      extract_from_element_list list: node.element_children.select{|c| c.element_children.size >= 1}, mapping: list_element_mappings, entity: m

      m
    end
  end

  module ContactInfoFactory
    extend self
    extend MappingHelper

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
       'STREET' => [:street],
       'ZIP' => [:zip],
       'CITY' => [:city],
       'COUNTRY' => [:country,  country_lambda(country_mappings)]
      }
    end

    def simple_attribute_mappings
      {
       'type' => [:type],
      }
    end

    def build_model node
      a = ::ContactInfo.new

      extract_from_attribute_list list: node.attributes, mapping: simple_attribute_mappings, entity: a
      extract_from_element_list list: node.element_children.select{|c| c.children.size == 1}, mapping: simple_element_mappings, entity: a

      ignored = ['_id', 'country', 'type']
      a.attributes.except(*ignored).empty? ? nil : a
    end
  end
end