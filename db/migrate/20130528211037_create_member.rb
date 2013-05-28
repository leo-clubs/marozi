class CreateMember < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :oid
      t.string :year
      t.boolean :current
      t.string :name

      t.string :first_name
      t.string :last_name
      t.date   :member_since
      t.date   :date_of_birth
      t.string :gender
      t.string :languages, array: true
      t.string :profession
      t.string :type

      t.integer :club_id
      t.timestamps
    end
  end
end