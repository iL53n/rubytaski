json.task do
  json.extract! @task,
    :id,
    :title,
    :description,
    :order
end
