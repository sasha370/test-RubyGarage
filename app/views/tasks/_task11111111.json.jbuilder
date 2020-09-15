json.extract! task, :id, :name, :status, :belongs_to, :created_at, :updated_at
json.url project_task_url(project, task, format: :json)
