class Club < ActiveRecord::Base
  include Versioning
  include MemberStatistics
  include ProvidesOffices

  has_many :members, autosave: true
  belongs_to :district

  alias_method :parent, :district
  alias_method :children, :members

  def self.find_by_member_id oid
    m = Member.find_by_member_id oid
    m.club if m
  end

  def members_sorted
    members.sort{|a, b| a.last_name.downcase <=> b.last_name.downcase}
  end

  def age
    Time.zone.now.year - founded_at.year rescue 0
  end
end