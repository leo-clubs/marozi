class District
  include Mongoid::Document
  include Mongoid::Timestamps
  include Versioning

  field :name, type: String

  embeds_many :offices
  embeds_one :contact_infos

  belongs_to :multiple_district
  has_many :clubs, autosave: true
end