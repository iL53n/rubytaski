json.task do
  json.extract! @task,
    :id,
    :title,
    :description,
    :order,
    :stars_count
end
