class Member < ActiveRecord::Base
  include Versioning

  has_many :contact_infos, as: :contactable
  belongs_to :club

  alias_method :parent, :club

  def self.find_by_member_id oid
    self.where(oid: oid).first
  end
end