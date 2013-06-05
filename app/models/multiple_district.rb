class MultipleDistrict < ActiveRecord::Base
  include Versioning

  has_many :districts
  has_many :offices, as: :provides_offices
  has_many :committees

  alias_method :children, :districts

  def self.find_by_member_id oid
    d = District.find_by_member_id oid
    d.multiple_district if d
  end

  def districts_sorted
    # TODO let the database take care of it
    districts.sort{|a,b| a.name <=> b.name}
  end

  def settings
    Setting.where(multiple_district: self.oid)
  end

  def add_setting(s)
    s.multiple_district = self.oid
    s.save!
  end

  def create_committees types
    types = [types] unless types.is_a? Array
    types.each do |type|
      office = self.offices.where(name: :"#{type}_appointee").first
      if office.nil?
        puts "WARN: no MD-officer of type #{type.inspect} found"
      else
        c = Committee.find_or_create_by(kind: type)
        c.update_attributes(
          year: self.year,
          chairperson_id: office.member_id
          )
        self.committees << c
      end
    end
    self.save!
  end
end