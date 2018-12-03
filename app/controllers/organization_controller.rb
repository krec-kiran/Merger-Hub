class OrganizationController < ApplicationController

  layout :false, only: [:organization_filters, :organization_list, :organization_sectors, :organization_detail, :ma_transaction, :advisor_transaction]

  def index
  end

  def organization_filters
    @success = true
    @companies = Company.order("name")
    @sectors = Sector.order("name")
    @countries = Location.pluck(:country).uniq.compact
    @cities = Location.pluck(:city).uniq.compact
  end

  def organization_list
    company_id = params["company_id"]
    sector_id = params["sector_id"]
    city = params["city"]
    country = params["country"]
    hiring = params["hiring"]
    fundraising = params["fundraising"]

    company_id = Company.pluck(:id) if company_id.blank?
    sector_id = Sector.pluck(:id) if sector_id.blank?

    @organization = Company.searchOrganization(company_id, sector_id, city, country, hiring, fundraising)

    @success = @organization ? true : false
  end

  def organization_sectors
    @company_sectors = CompanySector.list_company_sectors
    @success = @company_sectors ? true : false
  end

  def organization_detail
    company_id = params["id"]
    @company = Company.find(company_id)
    @success = @company ? true : false
  end

  def ma_transaction
    company_id = params["id"]
    company = Company.find(company_id)
    @transactions = company.ma_transactions.approved.order("date desc")
    @success = @transactions ? true : false
  end

  def advisor_transaction
    advisor_id = params["id"]
    advisor = Advisor.find_by(advisor_id: advisor_id) if advisor_id
    @advisor_transactions = advisor.advisor_transactions.order("date desc") if advisor
    @success = @advisor_transactions ? true : false
  end

end
