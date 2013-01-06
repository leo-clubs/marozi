module Versioning
  extend ActiveSupport::Concern

  included do
    field :leo_id, type: Integer
    field :year, type: String

    default_scope where(year: '2012-2013')
  end
end