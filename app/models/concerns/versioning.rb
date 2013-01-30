module Versioning
  extend ActiveSupport::Concern

  included do
    field :leo_id, type: Integer
    field :year, type: String

    before_create :create_new_id

    default_scope where(year: '2012-2013')
  end

  def create_new_id
    self.leo_id ||= self.class.settings.first.inc(self.class.field_name, 1)
  end

  def current_multiple_district_id
    if self.class == MultipleDistrict
      self.leo_id
    else
      parent.current_multiple_district_id
    end
  end

  module ClassMethods
    def set_max_id
      settings.set(field_name, self.max(:leo_id).to_i)
    end

    def settings
      Setting.where(key: :max_ids)
    end

    def field_name
      self.collection_name
    end
  end
end