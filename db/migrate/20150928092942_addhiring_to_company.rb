class AddhiringToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :hiring, :boolean
    add_column :companies, :fund_raising, :boolean
  end
end
