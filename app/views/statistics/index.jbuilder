json.stat do
  json.general @stat.general_stat
  json.tasks   @stat.tasks_stat
  json.goals   @stat.goals_stat
  json.stars   @stat.stars_stat

  json.heatmap @stat.heatmap_chart
  json.treemap @stat.treemap_chart

  json.stars_date_count @stat.stars_date_count
end
