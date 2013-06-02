class Committee < ActiveRecord::Base
  include Versioning
  belongs_to :multiple_district
  has_many :members
  has_one :member, as: :chairperson
end