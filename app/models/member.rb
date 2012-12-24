class Member
  include Mongoid::Document

  field :leo_id, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :member_since, type: Date
  field :date_of_birth, type: Date
  field :gender, type: Symbol
  field :languages, type: Array
  field :profession, type: String

  embeds_many :addresses

  belongs_to :club
end