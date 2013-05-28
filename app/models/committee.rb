class Committee < ActiveRecord::Base
  include Versioning

  def members
    Member.where(:oid.in => (member_ids + [chairperson_id]))
  end

  def chairperson
    Member.where(oid: self.chairperson_id).first
  end
end