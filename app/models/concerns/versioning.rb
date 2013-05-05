module Versioning
  extend ActiveSupport::Concern

  included do
    field :oid, type: Integer
    field :year, type: String

    before_create :create_new_id

    index({ oid: 1, year: -1 }, { unique: true })

    default_scope where(year: '2012-2013')
  end

  def create_new_id
    self.oid ||= self.class.settings.first.inc self.class.field_name => 1
  end

  def current_multiple_district_id
    if self.class == MultipleDistrict
      self.oid
    else
      parent.current_multiple_district_id
    end
  end

  module ClassMethods
    def set_max_id
      settings.set field_name => self.max(:oid).to_i
    end

    def settings
      Setting.where(key: :max_ids)
    end

    def field_name
      self.collection_name
    end
  end
end