class AddTempTokenToUser < ActiveRecord::Migration
  def change
     add_column :users, :temp_token, :text
  end
end
