class CompanySector < ActiveRecord::Base
  belongs_to :company
  belongs_to :sector

  delegate :name, to: :company, allow_nil: true, prefix: :company
  delegate :name, to: :sector, allow_nil: true, prefix: :sector

  scope :list_company_sectors, -> {
      joins(:company,:sector).
      select("sectors.id as sector_id, sectors.name as sector_name, count(company_sectors.company_id) as company_count").
      group("sectors.id").
      order("sectors.name")
    }


end
