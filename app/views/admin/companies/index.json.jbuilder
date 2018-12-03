json.array!(@admin_companies) do |admin_company|
  json.extract! admin_company, :id, :name, :employees_count, :established_date, :summary, :website
  json.url admin_company_url(admin_company, format: :json)
end
