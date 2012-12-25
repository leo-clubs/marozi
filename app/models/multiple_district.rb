class MultipleDistrict
  include Mongoid::Document

  field :leo_id, type: String
  field :name, type: String

  embeds_many :offices

  has_many :districts, autosave: true
end