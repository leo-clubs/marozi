class EmailAddress
  include Mongoid::Document

  field :type, type: Symbol
  field :address, type: String
end
