class AddColumnsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :email, :string
    add_column :companies, :revenue, :string
  end
end
