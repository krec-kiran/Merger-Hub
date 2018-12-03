class AddStripeCustomerIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :stripe_customer_id, :string
    add_column :users, :is_paid_user, :boolean, default: false
  end
end
