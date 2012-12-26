class MultipleDistrict
  include Mongoid::Document
  include Mongoid::Timestamps
  include Versioning

  field :name, type: String

  embeds_many :offices

  has_many :districts, autosave: true

  def self.find_by_member_id leo_id
    d = District.find_by_member_id leo_id
    d.multiple_district if d
  end
end