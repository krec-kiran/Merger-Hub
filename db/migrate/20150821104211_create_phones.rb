class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :mobile
      t.string :fax
      t.string :landline
      t.integer :company_id

      t.timestamps null: false
    end
  end
end
