class Committee
  include Mongoid::Document
  include Mongoid::Timestamps
  include Versioning

  field :type, type: Symbol
  field :chairperson_id, type: Integer
  field :member_ids, type: Array, default: []

  def members
    Member.where(:leo_id.in => (member_ids + [chairperson_id]))
  end

  def chairperson
    Member.where(leo_id: self.chairperson_id).first
  end
end