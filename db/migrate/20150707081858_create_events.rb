class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :host_id
      t.string :address
      t.float :latitude
      t.float :longitude
      t.text :description
      t.datetime :date

      t.timestamps null: false
    end
  end
end
