module Import

  module MemberFactory
    extend self

    date_lambda = lambda {|v| Date.parse(v)}
    extract_locale = lambda do |v|
      base_lang = [:de]
      begin
        additional_langs = v.xpath('//NAME/text()').map{|e| e.text.to_sym}
      rescue
        additional_langs = []
      end
      (base_lang + additional_langs).sort
    end

     SIMPLE_MEMBER_MAPPINGS = {
       'membershipStart' => [:member_since,  date_lambda],
       'FIRSTNAME' => [:first_name, lambda {|v| v} ],
       'LASTNAME' => [:last_name, lambda {|v| v} ],
       'BIRTHDATE' => [:date_of_birth,  date_lambda],
       'SEX' => [:gender, lambda {|v| v.strip == 'M' ? :male : :female } ]
     }

     LIST_MEMBER_MAPPINGS = {
      'LANGUAGES' => [:languages, extract_locale]
     }


    def build_model node
      m = ::Member.new

      # load attributes
      node.attributes.each do |a|
        according_value = SIMPLE_MEMBER_MAPPINGS[a[0]]
        if according_value
          m.send("#{according_value[0]}=", according_value[1].call(a[1].value))
        end
      end

      # load simple elements
      node.element_children.select{|c| c.children.size == 1}.each do |n|
        according_value = SIMPLE_MEMBER_MAPPINGS[n.name]
        if according_value
          m.send("#{according_value[0]}=", according_value[1].call(n.text))
        end
      end

      # load list elements
      node.element_children.select{|c| c.element_children.size > 1}.each do |n|
        according_value = LIST_MEMBER_MAPPINGS[n.name]
        if according_value
          m.send("#{according_value[0]}=", according_value[1].call(n))
        end
      end
      m
    end
  end

  module AddressFactory
    extend self

    def build_model node
      m = ::Address.new
    end
  end
end