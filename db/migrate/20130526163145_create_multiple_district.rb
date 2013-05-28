class CreateMultipleDistrict < ActiveRecord::Migration
  def change
    create_table :multiple_districts do |t|
      t.integer :oid
      t.string :year
      t.boolean :current
      t.string :name

      t.timestamps
    end
  end
end