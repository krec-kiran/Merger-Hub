json.array!(@feeds) do |feed|
  json.extract! feed, :id, :title, :url, :image_url, :entry_url, :author, :category, :summary, :published
  json.url feed_url(feed, format: :json)
end
