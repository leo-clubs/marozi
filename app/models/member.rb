class Member
  include Mongoid::Document
  include Mongoid::Timestamps
  include Versioning

  field :first_name, type: String
  field :last_name, type: String
  field :member_since, type: Date
  field :date_of_birth, type: Date
  field :gender, type: Symbol
  field :languages, type: Array
  field :profession, type: String
  field :type, type: Symbol

  embeds_many :contact_infos
  accepts_nested_attributes_for :contact_infos, allow_destroy: true

  belongs_to :club

  alias_method :parent, :club

  def self.find_by_member_id leo_id
    self.where(leo_id: leo_id).first
  end

  def date_of_birth_formatted
    date_field_formatted(:date_of_birth)
  end

  def member_since_formatted
    date_field_formatted(:member_since)
  end

  private
  def date_field_formatted field
    send(field).strftime('%Y-%m-%d')
  end
end