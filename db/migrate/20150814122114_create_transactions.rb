class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.datetime :date
      t.integer :target_id
      t.integer :sector_id
      t.float :value
      t.integer :transaction_type_id
      t.integer :investor_id
      t.integer :seller_id

      t.timestamps null: false
    end
  end
end
