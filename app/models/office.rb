class Office < ActiveRecord::Base
  include Versioning
  belongs_to :provides_offices, polymorphic: true
  alias_method :parent, :provides_offices

  def member
    Member.where(oid: self.member_id).first
  end

  def member= m
    self.member_id = m.oid
  end
end