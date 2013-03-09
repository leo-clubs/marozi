module Finders
  def member_and_club_by_member_id member_id
    m = club_by_member_id(member_id)
    [m, m.club]
  end

  def club_by_member_id member_id
    Member.where(leo_id: member_id).first
  end

  def club_by_club_id club_id
    Club.where(leo_id: club_id).first
  end
end