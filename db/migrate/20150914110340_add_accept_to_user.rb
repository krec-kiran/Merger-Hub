class AddAcceptToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_accept, :boolean
  end
end
