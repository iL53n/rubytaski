json.task do
  json.extract! @task,
    :id,
    :title,
    :description,
    :created_at,
    :updated_at,
    :order,
    :stars_count
end
