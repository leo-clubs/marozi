class Club
  include Mongoid::Document
  include Mongoid::Timestamps
  include Versioning

  field :name, type: String
  field :founded_at, type: Date
  field :chartered_at, type: Date
  field :godfather, type: String
  field :meet_description, type: String
  field :bank, type: String
  field :homepage, type: String

  embeds_many :offices
  embeds_one :contact_infos

  has_many :members, autosave: true
  belongs_to :district

  def self.find_by_member_id leo_id
    m = Member.find_by_member_id leo_id
    m.club if m
  end
end