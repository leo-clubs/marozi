class District
  include Mongoid::Document

  field :leo_id, type: String
  field :name, type: String

  embeds_many :offices
  embeds_one :contact_infos

  has_many :clubs, autosave: true
end