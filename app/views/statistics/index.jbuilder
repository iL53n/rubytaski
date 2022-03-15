json.stat do
  json.general @stat.general_stat
  json.tasks   @stat.tasks_stat
  json.goals   @stat.goals_stat
  json.stars   @stat.stars_stat
end
