class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :pin_code
      t.integer :company_id
      t.boolean :is_headquarter, default: true

      t.timestamps null: false
    end
  end
end
