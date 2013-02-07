class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :name
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :phone_number
      t.integer :user_id

      t.timestamps
    end
  end
end
