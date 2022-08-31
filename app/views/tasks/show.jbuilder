json.task do
  json.extract! @task,
                :id,
                :title,
                :description,
                :state,
                :created_at,
                :updated_at,
                :order,
                :stars_count,
                :current_streak,
                :longest_streak
end
