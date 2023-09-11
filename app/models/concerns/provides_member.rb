module ProvidesMember
  extend ActiveSupport::Concern

 def member
    Member.where(oid: self.member_id).first
  end

  def member= m
    self.member_id = m.oid
  end
end