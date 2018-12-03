class ChangeColumn < ActiveRecord::Migration
  def change
    rename_column :advisors, :type, :advisor_type
  end
end
