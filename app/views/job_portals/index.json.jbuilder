json.array!(@job_portals) do |job_portal|
  json.extract! job_portal, :id, :title, :summary, :requirement, :email, :posted_date, :location_id, :user_id, :is_accept
  json.url job_portal_url(job_portal, format: :json)
end
