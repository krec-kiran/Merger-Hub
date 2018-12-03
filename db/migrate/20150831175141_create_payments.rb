class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :stripe_customer_token
      t.references :user, index: true, foreign_key: true
      t.string :email
      t.integer :plan

      t.timestamps null: false
    end
  end
end
