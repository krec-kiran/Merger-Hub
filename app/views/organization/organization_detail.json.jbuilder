json.success @success
json.response do
  json.company do
    json.id @company.id
    json.name @company.name
    json.employees_count @company.employees_count
    json.established_date @company.established_date
    json.sector_name @company.sectors.pluck(:name).join(",")
    json.summary @company.summary
    json.website @company.website
    json.email @company.email
    json.revenue @company.revenue
    @company.hiring ?  status = "Hiring" : status = ""
    json.hiring status
    @company.fund_raising ? status = "Fund raising" : status = ""
    json.fund_raising status
    json.company_type @company.company_type.name
    json.address @company.locations.first.full_address if @company.locations.present?
    json.phone @company.phones.pluck(:landline).join(",") if @company.phones.present?

    json.employees do
      json.array! @company.candidates do |person|
        json.id person.id
        json.name person.name
        json.email person.email
        json.company_name person.company_name
        json.company_id person.company.id
        json.sector_name person.company.sectors.pluck(:name).join(",")
        json.designation person.designation
        json.city person.city
        json.location person.full_address
      end
    end
    json.jobs @company.job_portals.accepted if @company
  end
end