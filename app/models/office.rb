class Office
  include Mongoid::Document

  field :name, type: String
  field :member_id, type: String
end