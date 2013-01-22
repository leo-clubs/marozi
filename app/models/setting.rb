class Setting
  include Mongoid::Document

  field :key, type: Symbol

  index({ key: 1 }, { unique: true, name: 'settings_index' })

  # all the other fields are dynamic
end