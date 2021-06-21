json.extract! task, :id, :name, :discription, :priority, :deadline, :status, :created_at, :updated_at
json.url task_url(task, format: :json)
