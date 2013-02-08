class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.decimal :price, :precision => 8, :scale => 2
      t.integer :venue_id

      t.timestamps
    end
  end
end
