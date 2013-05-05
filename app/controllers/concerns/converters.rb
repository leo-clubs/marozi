module Converters
  def xeditable_to_rails_params hash
    hash.class.new.tap do |return_hash|
      return_hash[hash['name'].to_sym] = hash['value']
    end
  end

  def person_array_to_xeditable person_array, operation = nil
    person_array.map do | person |
      {
        value: person.oid,
        text: operation ? operation.call(person) : person
      }
    end
  end
end