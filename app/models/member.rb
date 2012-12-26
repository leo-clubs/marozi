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

  embeds_many :contact_infos

  belongs_to :club

  def self.find_by_member_id leo_id
    self.where(leo_id: leo_id).first
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      self.any_of({ leo_id: /^#{Regexp.escape(login)}$/i }).first
    else
      super
    end
  end
end