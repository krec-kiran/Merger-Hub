class AddFieldsToCandidates < ActiveRecord::Migration
  def change
    remove_column :candidates, :sector_id
    add_column :candidates, :designation, :text
    add_column :candidates, :joined, :string
    add_column :candidates, :bio, :text
    add_column :candidates, :work_history, :text
    add_column :candidates, :industry_specialty, :text
    add_column :candidates, :board_member, :string
    add_column :candidates, :education, :text
    add_column :candidates, :phone, :string
  end
end
