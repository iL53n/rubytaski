json.stat do
  json.extract! @stat,
    :general_stat,
    :tasks_stat,
    :goals_stat,
    :stars_stat
end
