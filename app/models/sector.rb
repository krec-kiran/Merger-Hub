class Sector < ActiveRecord::Base
  has_many :company_sectors
  has_many :companies, through: :company_sectors
  has_many :sites
end
