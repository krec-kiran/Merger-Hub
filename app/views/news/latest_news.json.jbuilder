json.success @status
json.response do
  json.entries do
    json.array! @entries do |entry|
      json.title entry.title
      json.site_name entry.site.name
      json.url entry.url
      json.image_url entry.image_url
      json.entry_url entry.entry_url
      json.author entry.author
      json.category  entry.category
      json.summary entry.summary
      json.published entry.published
    end
  end
end