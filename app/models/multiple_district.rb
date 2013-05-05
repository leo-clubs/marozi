class MultipleDistrict
  include Mongoid::Document
  include Mongoid::Timestamps
  include ProvidesOffices

  field :name, type: String

  has_many :districts, autosave: true

  alias_method :children, :districts

  def self.find_by_member_id oid
    d = District.find_by_member_id oid
    d.multiple_district if d
  end

  def districts_sorted
    districts.sort{|a,b| a.name <=> b.name}
  end

  def create_committees types
    types = [types] unless types.is_a? Array
    types.each do |type|
      office = self.offices.where(name: :"#{type}_appointee").first
      c = Committee.find_or_create_by(type: type)
      c.update_attributes chairperson_id: office.member_id
    end
  end
end