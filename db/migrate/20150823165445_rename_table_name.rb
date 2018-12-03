class RenameTableName < ActiveRecord::Migration
  def change
    rename_table :transactions, :ma_transactions
    rename_column :investors, :transaction_id, :ma_transaction_id
    change_column :ma_transactions, :value,  :string
  end
end
