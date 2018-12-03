class AddColumnsToTransactions < ActiveRecord::Migration
  def change
    remove_column :transactions, :sector_id
    remove_column :transactions, :seller_id
    remove_column :transactions, :investor_id
    add_column :transactions, :company_id, :integer

    rename_column :transaction_types, :transaction_type, :name
  end
end
