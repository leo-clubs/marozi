class CreateSetting < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string  :key
      t.string  :value
      t.integer :multiple_district

      t.timestamps
    end
  end
end
