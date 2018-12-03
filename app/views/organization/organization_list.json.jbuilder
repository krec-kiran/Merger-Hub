json.success @success
json.response do
  json.array! @organization do |organization|
    json.id organization.company_id
    json.name organization.name
    json.phone organization.landline.join(", ")
    json.website organization.website
    json.revenue organization.revenue
    json.sector_name organization.sector_name
    json.location_id organization.location_id
    json.address Location.find(organization.location_id).full_address
  end
end