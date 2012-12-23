class Address
  include Mongoid::Document

  field :type, type: Symbol
  field :street, type: String
  field :zip, type: String
  field :city, type: String
  field :country, type: String
end
