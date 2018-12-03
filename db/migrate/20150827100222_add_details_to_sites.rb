class AddDetailsToSites < ActiveRecord::Migration
  def change
    add_column :sites, :sector_id, :integer
    add_column :sites, :is_sellside, :boolean
    add_column :sites, :is_buyside, :boolean
    add_column :sites, :is_movers, :boolean
    add_column :sites, :size_of_deal, :string
    add_column :sites, :geo_id, :integer
  end
end
