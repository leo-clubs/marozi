module Versioning
  extend ActiveSupport::Concern

  included do
    default_scope { where(current: true) }
    before_create :assign_new_id
  end

  def assign_new_id
    self.oid = (self.class.unscoped.maximum(:oid) || 0 ) + 1
  end

  def current_multiple_district_id
    if self.class == MultipleDistrict
      self.oid
    else
      parent.current_multiple_district_id
    end
  end
end