class CreateInvestors < ActiveRecord::Migration
  def change
    create_table :investors do |t|
      t.references :transaction, index: true, foreign_key: true
      t.integer :buyer_id, index: true
      t.integer :seller_id, index: true
      t.timestamps null: false
    end
  end
end
