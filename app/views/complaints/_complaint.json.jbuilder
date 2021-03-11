json.extract! complaint, :id, :title, :desc, :status, :user_id, :created_at, :updated_at
json.url complaint_url(complaint, format: :json)
