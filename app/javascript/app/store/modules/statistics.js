export default {
  state: {
    general: {
      active_days: 0
    },
    tasks: {
      all: 0,
      all_active: 0
    },
    goals: {
      all: 0,
      current: {
        id: 0,
        number_of_stars: 0,
        completed_stars: 0
      }
    },
    stars: {
      all: 0,
      current_year: 0,
      current_month: 0,
      current_week: 0,
      current_day: 0
    },
    heatmap: {},
    treemap: {}
  },
  mutations: {
    updateTasksStatistics(state, values) {
      state.general.active_days = values.active_days
    },
    updateTasksStatistics(state, values) {
      state.tasks.all        = values.all,
      state.tasks.all_active = values.all_active
    },
    updateGoalsStatistics(state, values) {
      state.goals.all                     = values.all,
      state.tasks.current.number_of_stars = values.number_of_stars
    },
    updateStarsStatistics(state, values) {
      state.stars.all           = values.all,
      state.stars.current_year  = values.current_year,
      state.stars.current_month = values.current_month,
      state.stars.current_week  = values.current_week,
      state.stars.current_day   = values.current_day
      state.stars.current_goal  = values.current_goal
    },
    updateHeatmapStatistics(state, values) {
      state.heatmap = values
    },
  },
  actions:   {}
}