module Import
  module MappingHelper

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

    def integer_lambda
      lambda {|v| v.to_i}
    end

    def profession_lambda
      lambda {|v| v.xpath('.//DESCRIPTION/text()').first.text rescue nil}
    end

    def office_to_member_lambda
      lambda {|v| v['id']}
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
          contact_info = ContactInfoFactory.new(a).build_model
          contact_infos << contact_info if contact_info
        end
        contact_infos.sort{|a,b| a.type <=> b.type}
      end
    end

    def member_lambda(year)
      simple_list_lambda 'MEMBER', MemberFactory, year
    end

    def club_lambda(year)
      simple_list_lambda 'CLUB', ClubFactory, year
    end

    def district_lambda(year)
      simple_list_lambda 'DISTRICT', DistrictFactory, year
    end

    def office_lambda(year)
      simple_list_lambda 'OFFICER', OfficeFactory
    end

    def mapping_lambda mapping, default
      lambda {|v| mapping[v] || default}
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

    def extract_from_element_list opts, already_found = []
      opts[:list].each do |n|
        according_value = opts[:mapping][n.name]
        if according_value
          value = according_value[1].class == Proc ? according_value[1].call(n) : n.text
          if !already_found.include?(n.name)
            opts[:entity].send("#{according_value[0]}=", value) unless already_found.include?(value)
            already_found << n.name
          end
        elsif n.element_children
          extract_from_element_list(opts.merge({list: n.element_children}), already_found)
        end
      end
    end

    private
    def simple_list_lambda identifier, klazz, year = nil
      lambda do |v|
        members = []
        v.xpath(".//#{identifier}").each do |m|
          args = [m,year].select{|a| a}
          members << klazz.new(*args).build_model
        end
        members
      end
    end
  end
end