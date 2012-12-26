class MultipleDistrict
  include Mongoid::Document
  include Mongoid::Timestamps
  include Versioning

  field :name, type: String

  embeds_many :offices

  has_many :districts, autosave: true
end