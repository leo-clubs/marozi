class Member
  include Mongoid::Document

  field :member_id, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :member_since, type: Date
  field :birthday, type: Date
  field :gender, type: String

  embeds_many :addresses
  embeds_many :emails
  embeds_many :phone_numbers
end