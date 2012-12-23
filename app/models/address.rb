class Address
  include Mongoid::Document

  field :type, type: Symbol
  field :street, type: String
  field :zip, type: String
  field :city, type: String
  field :country, type: String
  field :email_address, type: String
  field :phone_number, type: String
  field :mobile_phone_number, type: String
  field :fax_number, type: String
end
