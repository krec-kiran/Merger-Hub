class CreateTransactionTypes < ActiveRecord::Migration
  def change
    create_table :transaction_types do |t|
      t.string :transaction_type

      t.timestamps null: false
    end
  end
end
