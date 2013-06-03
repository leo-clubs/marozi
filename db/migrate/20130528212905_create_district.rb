class CreateDistrict < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.integer :oid
      t.string :year
      t.boolean :current

      t.string :name
      t.integer :multiple_district_id
    end
  end
end
