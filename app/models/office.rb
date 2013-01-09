class Office
  include Mongoid::Document
  include Versioning

  field :name, type: Symbol
  field :member_id, type: Integer
  field :parent_id, type: Integer
end