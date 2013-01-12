module XEditableConverter
  refine Hash do
    def to_rails_params
      self.class.new.tap do |hash|
        hash[self['name'].to_sym] = self['value']
      end
    end
  end
end