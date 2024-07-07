json.extract! job, :id, :title, :description, :company, :location, :created_at, :updated_at
json.url job_url(job, format: :json)
