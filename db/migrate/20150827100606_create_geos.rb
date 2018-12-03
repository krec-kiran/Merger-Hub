class CreateGeos < ActiveRecord::Migration
  def change
    create_table :geos do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
