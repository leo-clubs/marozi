module ProvidesOffices
  extend ActiveSupport::Concern
  include Versioning

  def offices= arr
    arr.each do |office|
      office.parent_id = self.leo_id
      office.save!
    end
  end

  def offices
    Office.where(parent_id: self.leo_id)
  end
end