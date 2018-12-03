class CreateCompanyTypes < ActiveRecord::Migration
  def change
    create_table :company_types do |t|
      t.string :name

      t.timestamps null: false
    end
    add_column :companies, :company_type_id, :integer, default: 1
  end
end
