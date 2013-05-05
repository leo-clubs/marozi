class District
  include Mongoid::Document
  include Mongoid::Timestamps
  include ProvidesOffices

  field :name, type: String

  embeds_one :contact_infos

  belongs_to :multiple_district
  has_many :clubs, autosave: true

  alias_method :parent, :multiple_district
  alias_method :children, :clubs

  def self.find_by_member_id oid
    c = Club.find_by_member_id oid
    c.district if c
  end

  def clubs_sorted
    clubs.sort{|a,b| a.name <=> b.name}
  end
end