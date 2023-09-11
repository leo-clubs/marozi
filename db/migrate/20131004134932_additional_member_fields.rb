class AdditionalMemberFields < ActiveRecord::Migration
  def change
    add_column :members, :academic_title, :string
  end
end
