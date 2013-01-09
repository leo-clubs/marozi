class Office
  include Mongoid::Document

  field :name, type: Symbol
  field :member_id, type: Integer
end