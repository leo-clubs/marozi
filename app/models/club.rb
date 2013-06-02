class Club < ActiveRecord::Base
  include Versioning

  has_many :members, autosave: true
  has_many :offices, as: :provides_offices
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

  def age_distribution
    males, females = members.select{|m| m.kind == :active}.partition{|m| m.gender == :male}

    h = {
      male: males.map{|m| m.age},
      female: females.map{|m| m.age},
    }

    male_distribution = []
    female_distribution = []

    (18..31).each do |age|
      male_distribution << {
        label: age,
        value: h[:male].count(age),
      }

      female_distribution << {
        label: age,
        value: h[:female].count(age),
      }
    end

    [
      {
        key: 'Male Members',
        values: male_distribution,
      },
      {
        key: 'Female Members',
        values: female_distribution,
      },
    ]
  end
end