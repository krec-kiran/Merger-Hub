class AddDetailsToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :employees_count, :integer
    add_column :companies, :established_date, :date
    add_column :companies, :summary, :text
    add_column :companies, :website, :string
  end
end
