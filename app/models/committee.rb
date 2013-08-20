class Committee < ActiveRecord::Base
  include Versioning
  belongs_to :multiple_district

  def members
    []
  end

  def chairperson
    Member.where(oid: self.chairperson_id).first
  end
end