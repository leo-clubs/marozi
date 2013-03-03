module MemberFinders
  extend ActiveSupport::Concern

  def member_and_club member_id
    m = Member.where(leo_id: member_id).first
    [m, m.club]
  end
end