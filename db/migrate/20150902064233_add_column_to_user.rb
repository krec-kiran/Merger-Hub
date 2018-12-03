class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :subscription, :integer
    add_column :users, :remaining_days, :integer
  end
end
