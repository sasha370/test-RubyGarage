json.extract! task, :id, :name, :status, :belongs_to, :created_at, :updated_at
json.url task_url(task, format: :json)
