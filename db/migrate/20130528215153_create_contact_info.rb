class CreateContactInfo < ActiveRecord::Migration
  def change
    create_table :contact_infos do |t|
      t.string :kind
      t.string :street
      t.string :zip
      t.string :city
      t.string :country
      t.string :email_address
      t.string :phone_number
      t.string :mobile_phone_number
      t.string :fax_number
      t.string :homepage

      t.references :contactable, polymorphic: true
      t.timestamps
    end
  end
end
