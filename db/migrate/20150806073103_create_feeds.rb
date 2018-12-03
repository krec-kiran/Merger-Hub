class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.text :url
      t.text :image_url
      t.text :entry_url
      t.string :author
      t.text :category, array: true, default: []
      t.text :summary
      t.references :site, index: true, foreign_key: true
      t.datetime :published

      t.timestamps null: false
    end
  end
end
