class Committee
  include Mongoid::Document
  include Mongoid::Timestamps
  include Versioning

  field :type, type: Symbol
  field :chairperson_id, type: Integer

  def members
    Member.where(leo_id: self.leo_id).entries
  end
end