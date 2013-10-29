module ProvidesOffices
  extend ActiveSupport::Concern

  def offices
    Office.where(
      provides_offices_id: self.oid,
      provides_offices_type: self.class.to_s
    )
  end
end