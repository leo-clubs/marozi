module Import
  module Helper

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
        base_lang = [:deu]
        begin
          additional_langs = v.xpath('.//NAME/text()').map do |lang|
            lang_string = lang.to_s
            premap_languages.fetch(lang_string) do |to_be_mapped_lang|
              language_wrapper = LanguageList::LanguageInfo.find(to_be_mapped_lang)
              if language_wrapper.nil?
                puts "language #{to_be_mapped_lang.inspect} not found"
              else
                language_wrapper.iso_639_3.to_sym
              end
            end
          end.compact
        rescue Exception => e
          puts "Language error: #{e.message }"
          additional_langs = []
        end
        (base_lang + additional_langs).uniq.sort
      end
    end

    def premap_languages
      @premap ||= {
        'per' => :fas,
        'vietn' => :vie,
        'sing' => :sin,
        'srcr' => :hbs,
        'gr' => :ell,
        'mand' => :cmn,
      }
    end

    def contact_info_lambda
      lambda do |v|
        contact_infos = []
        v.xpath('.//ADDRESS').each do |a|
          contact_info = ContactInfoImporter.new(a).build_model
          contact_infos << contact_info if contact_info
        end
        contact_infos.sort{|a,b| a.kind <=> b.kind}
      end
    end

    def member_lambda(year)
      simple_list_lambda 'MEMBER', MemberImporter, year
    end

    def club_lambda(year)
      simple_list_lambda 'CLUB', ClubImporter, year
    end

    def district_lambda(year)
      simple_list_lambda 'DISTRICT', DistrictImporter, year
    end

    def mapping_lambda mapping, default
      lambda do |v|
        lookup_key = v.class == String ? v : v.text
        mapping.fetch(lookup_key) { |el| puts("not found: #{el.inspect}"); default}
      end
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
        if opts[:mapping][n.name] && !already_found.include?(n.name)
          write_value opts[:entity], n, opts[:mapping][n.name], already_found
          already_found << n.name
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

    def write_value entity, node, raw_value, already_found
      value = raw_value[1].class == Proc ? raw_value[1].call(node) : node.text
      entity.send("#{raw_value[0]}=", value) unless already_found.include?(value)
    end
  end
end