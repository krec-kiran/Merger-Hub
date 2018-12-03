class CreateJobPortals < ActiveRecord::Migration
  def change
    create_table :job_portals do |t|
      t.string :title
      t.text :summary
      t.text :requirement
      t.string :email
      t.date :posted_date
      t.integer :location_id
      t.integer :user_id
      t.boolean :is_accept

      t.timestamps null: false
    end
  end
end
