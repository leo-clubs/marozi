class EmailAddress
  include Mongoid::Document

  field :type, type: String
  field :address, type: String
end
