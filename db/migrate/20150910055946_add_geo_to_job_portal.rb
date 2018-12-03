class AddGeoToJobPortal < ActiveRecord::Migration
  def change
    add_column :job_portals, :sector_name, :string
    add_column :job_portals, :geo_id, :integer
  end
end
