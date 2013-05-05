class Committee
  include Mongoid::Document
  include Mongoid::Timestamps
  include Versioning

  field :type, type: Symbol
  field :chairperson_id, type: Integer
  field :member_ids, type: Array, default: []

  def members
    Member.where(:oid.in => (member_ids + [chairperson_id]))
  end

  def chairperson
    Member.where(oid: self.chairperson_id).first
  end
end