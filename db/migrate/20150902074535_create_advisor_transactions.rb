class CreateAdvisorTransactions < ActiveRecord::Migration
  def change
    create_table :advisor_transactions do |t|
      t.integer :advisor_id
      t.integer :client_id
      t.integer :target_id
      t.date :date
      t.string :buy_or_sell

      t.timestamps null: false
    end
  end
end
