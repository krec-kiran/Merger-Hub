class AddApproveToMaTransaction < ActiveRecord::Migration
  def change
    add_column :ma_transactions, :is_approve, :boolean
    add_column :ma_transactions, :approved_by, :string
  end
end
