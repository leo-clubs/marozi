class Office
  include Mongoid::Document

  field :name, type: String
  belongs_to :member
end