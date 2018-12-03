class CreateInvestments < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.references :company, index: true, foreign_key: true
      t.string :status
      t.date :investment_date
      t.date :exit_date
      t.integer :investor_company_id
      t.timestamps null: false
    end
  end
end
