class AddDetailsToJobPortal < ActiveRecord::Migration
  def change
    add_column :job_portals, :company_name, :string
    add_column :job_portals, :website, :string
  end
end
