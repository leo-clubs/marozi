module MemberStatistics
  extend ActiveSupport::Concern

  def gender_ratio status
    f,m = members
            .select{|member| member.status == status}
            .partition{|member| member.gender == :female}
    {
      female: f.size,
      male: m.size,
    }
  end
end