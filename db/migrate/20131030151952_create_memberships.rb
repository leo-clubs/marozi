class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.date    :start
      t.date    :end
      t.integer :member_id
      t.integer :club_id

      t.timestamps
    end
  end
end
