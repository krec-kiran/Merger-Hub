class CreateCoverages < ActiveRecord::Migration
  def change
    create_table :coverages do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
