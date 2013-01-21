module Versioning
  extend ActiveSupport::Concern

  included do
    field :leo_id, type: Integer
    field :year, type: String

    default_scope where(year: '2012-2013')
  end

  module ClassMethods


    def set_max_id
      field_name = self.collection_name
      s = Setting.where(key: :max_ids)
      s.set(field_name, self.max(:leo_id).to_i)
    end
  end
end