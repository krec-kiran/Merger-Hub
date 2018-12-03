class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :email
      t.string :city
      t.string :language
      t.string :year
      t.references :company, index: true, foreign_key: true
      t.references :sector, index: true, foreign_key: true
      t.references :title, index: true, foreign_key: true
      t.references :vertical, index: true, foreign_key: true
      t.references :coverage, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
