module Versioning
  extend ActiveSupport::Concern

  included do
    field :leo_id, type: String
    field :year, type: String
  end
end