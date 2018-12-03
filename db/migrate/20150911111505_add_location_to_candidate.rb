class AddLocationToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :street, :string
    add_column :candidates, :state, :string
    add_column :candidates, :country, :string
    add_column :candidates, :pin_code, :string
  end
end
