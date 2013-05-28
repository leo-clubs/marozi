class CreateClub < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.integer :oid
      t.string :year
      t.boolean :current
      t.string :name

      t.string :name
      t.date :founded_at
      t.date :chartered_at
      t.string :godfather
      t.string :meet_description
      t.string :bank
      t.string :homepage

      t.integer :district_id
      t.timestamps
    end
  end
end
