class Office < ActiveRecord::Base
  include Versioning
  include ProvidesMember

  def provides_offices
    # will always return the current club/district/multiple_district
    Kernel.const_get(
      self.provides_offices_type)
        .where(
          oid: self.provides_offices_id,
        ).first
  end

  def provides_offices= po
    self.provides_offices_id = po.oid
    self.provides_offices_type = po.class.to_s
  end

  alias_method :parent, :provides_offices
end