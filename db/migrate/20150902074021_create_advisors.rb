class CreateAdvisors < ActiveRecord::Migration
  def change
    create_table :advisors do |t|
      t.integer :advisor_id
      t.integer :company_id
      t.string :type
      t.integer :engagement

      t.timestamps null: false
    end
  end
end
