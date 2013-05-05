class Club
  include Mongoid::Document
  include Mongoid::Timestamps
  include ProvidesOffices

  field :name, type: String
  field :founded_at, type: Date
  field :chartered_at, type: Date
  field :godfather, type: String
  field :meet_description, type: String
  field :bank, type: String
  field :homepage, type: String

  embeds_one :contact_infos

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