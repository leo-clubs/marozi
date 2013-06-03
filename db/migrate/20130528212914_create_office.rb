class CreateOffice < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.integer :oid
      t.string :year
      t.boolean :current

      t.string :name
      t.references :provides_offices, polymorphic: true
      t.integer :member_id
    end
  end
end
