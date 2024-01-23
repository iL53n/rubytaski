presenter = TaskPresenter.new

json.task do
  json.extract! presenter.present(@task), *presenter.columns_keys

  # json.extract! @task,
  #               :id,
  #               :title,
  #               :description,
  #               :state,
  #               :created_at,
  #               :updated_at,
  #               :order,
  #               :stars_count,
  #               :current_streak,
  #               :longest_streak,
  #               :has_reminder
end
