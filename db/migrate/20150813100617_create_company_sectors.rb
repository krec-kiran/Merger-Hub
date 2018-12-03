class CreateCompanySectors < ActiveRecord::Migration
  def change
    create_table :company_sectors do |t|
      t.integer :company_id, index: true, null: false
      t.integer :sector_id, index: true, null: false

      t.timestamps null: false
    end
  end
end
