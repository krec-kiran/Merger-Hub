json.success @success
json.response do
  json.array! @company_sectors do |company_sector|
    json.name company_sector.sector_name
    json.count company_sector.company_count
  end
end