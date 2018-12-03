class AddSkillToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :skills, :text
  end
end
