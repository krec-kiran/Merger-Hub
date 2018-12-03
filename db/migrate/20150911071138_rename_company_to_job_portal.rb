class RenameCompanyToJobPortal < ActiveRecord::Migration
  def change
    add_column :job_portals, :company_id, :integer
    remove_column :job_portals, :company_name, :string
  end
end
