class Company < ActiveRecord::Base
  belongs_to :company_type
  has_many :company_sectors, dependent: :destroy
  has_many :sectors, through: :company_sectors
  has_many :locations, dependent: :destroy
  has_many :phones, dependent: :destroy
  has_many :ma_transactions
  has_many :candidates
  has_many :job_portals

  validates :name, uniqueness: { case_sensitive: false }

  accepts_nested_attributes_for :locations, :phones, :company_sectors, :allow_destroy => true

  # validates :email, uniqueness: true

  scope :searchOrganization, -> (company_id, sector_id, city, country, hiring, fundraising) {
    search_str = ""
    search_str = " and LOWER(locations.city)='#{city.downcase}'" if city.present?
    search_str += " and LOWER(locations.country)='#{country.downcase}'" if country.present?
    search_str += " and companies.hiring = true" if hiring == "true"
    search_str += " and companies.fund_raising = true" if fundraising == "true"
    joins(:company_type, :sectors, :company_sectors, :locations, :phones).
    select("companies.id as company_id, companies.name, companies.website, companies.revenue, sectors.name as sector_name, locations.id as location_id, array_agg(phones.landline) as landline").
    where("companies.id in (?) and sectors.id in (?) #{search_str}", company_id,  sector_id).
    order("companies.name").group("companies.id, sectors.name, locations.id")
    }


end
