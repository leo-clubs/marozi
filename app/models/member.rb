class Member < ActiveRecord::Base
  include Versioning

  has_many :contact_infos, as: :contactable
  belongs_to :club

  symbolize :status, in: [:active, :passive, :honorary]
  symbolize :gender, in: [:male, :female]

  alias_method :parent, :club

  def self.find_by_member_id oid
    self.where(oid: oid).first
  end

  def offices(range=:current)
    base_query = Office.where(member_id: self.oid)
    range == :current ? base_query.where(year: self.year) : base_query
  end

  def age
    now = Time.now.utc.to_date
    dob = self.date_of_birth
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1) rescue 0
  end

  def offices
    # read all offices from database
  end
end