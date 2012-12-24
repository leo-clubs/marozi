class Club
  include Mongoid::Document

  field :leo_id, type: String
  field :name, type: String
  field :founded_at, type: Date
  field :chartered_at, type: Date
  field :godfather, type: String
  field :meet_description, type: String
  field :bank, type: String
  field :homepage, type: String

  embeds_many :office_mappings
  embeds_one :address

  has_many :members, autosave: true
end