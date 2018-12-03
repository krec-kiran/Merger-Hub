json.array!(@sites) do |site|
  json.extract! site, :id, :name, :url
  json.url site_url(site, format: :json)
end
