class CreateCommittee < ActiveRecord::Migration
  def change
    create_table :committees do |t|
      t.integer :oid
      t.string :year
      t.boolean :current

      t.string :type
      t.integer :chairperson_id
      t.integer :member_ids, array: true
      t.integer :multiple_district_id
      t.timestamps
    end
  end
end
