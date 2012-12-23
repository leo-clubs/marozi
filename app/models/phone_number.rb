class PhoneNumber
  include Mongoid::Document

  field :type, type: Symbol
  field :phone_number, type: String
end
