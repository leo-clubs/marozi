module Converters
  def xeditable_to_rails_params hash
    hash.class.new.tap do |return_hash|
      return_hash[hash['name'].to_sym] = hash['value']
    end
  end
end