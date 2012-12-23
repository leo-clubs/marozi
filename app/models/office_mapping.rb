class OfficeMapping
  include Mongoid::Document

  field :office, type: String
  has_one :member

end