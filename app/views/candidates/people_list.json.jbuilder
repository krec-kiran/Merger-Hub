json.success @success
json.response do
  json.people do
    json.array! @people do |person|
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
end