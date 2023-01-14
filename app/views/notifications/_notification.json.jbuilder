json.extract! notification, :id, :title, :body, :status, :created_at, :updated_at
json.url notification_url(notification, format: :json)
