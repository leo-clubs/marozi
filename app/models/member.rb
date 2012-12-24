class Member
  include Mongoid::Document

  field :leo_id, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :member_since, type: Date
  field :date_of_birth, type: Date
  field :gender, type: Symbol
  field :languages, type: Array
  field :profession, type: String

  embeds_many :addresses

  belongs_to :club

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      self.any_of({ leo_id: /^#{Regexp.escape(login)}$/i }).first
    else
      super
    end
  end
end