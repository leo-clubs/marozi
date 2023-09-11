class Membership < ActiveRecord::Base
  include ProvidesMember

  def club
    Club.where(oid: self.club_id).first
  end

  def club= c
    self.club_id = c.oid
  end
end
