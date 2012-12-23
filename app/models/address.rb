class Address
  include Mongoid::Document

  field :type, type: String
  field :street, type: String
  field :zip, type: String
  field :city, type: String
  field :country, type: String
end
