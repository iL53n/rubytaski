presenter = TaskPresenter.new

json.table do
  json.colums = TaskPresenter::COLUMNS

  json.data @tasks.resources do |resource|
    json.extract! presenter.present(resource), *presenter.columns_keys
  end

  json.set! :pagination do
    json.extract! @tasks.pagination, :page, :rowsPerPage, :rowsNumber
  end
end

json.schedule do
  json.data @tasks.resources do |resource|
    json.extract! presenter.present(resource), *presenter.columns_keys

    json.stars_dates resource.stars do |star|
      json.id        star.id
      json.state     star.state
      json.due_date  star.due_date&.to_date
      json.done_date star.done_date&.to_date
    end
  end
end
