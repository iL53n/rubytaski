presenter = TaskPresenter.new

json.task do
  json.extract! presenter.present(@task), *presenter.columns_keys

  json.extract! @task,
                :id,
                :title,
                :description,
                :state,
                :order,
                :stars_count,
                :current_streak,
                :longest_streak,
                :has_reminder,
                :created_formatted,
                :updated_formatted
end
