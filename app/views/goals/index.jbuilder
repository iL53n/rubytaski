presenter = GoalPresenter.new

json.table do
  json.colums = GoalPresenter::COLUMNS

  json.data @goals.resources do |resource|
    json.extract! presenter.present(resource), *presenter.columns_keys
  end

  json.set! :pagination do
    json.extract! @goals.pagination, :page, :rowsPerPage, :rowsNumber
  end
end