class Office
  include Mongoid::Document
  include Versioning

  field :name, type: Symbol
  field :member_id, type: Integer
  field :parent_id, type: Integer

  index({ name: 1, member_id: 1, parent_id: 1, year: 1 }, { unique: true })

  def member
    Member.where(oid: self.member_id).first
  end
end