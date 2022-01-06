export default {
  state:     {
    stars: {
      all: 0,
      current_year: 0,
      current_month: 0,
      current_week: 0,
      current_day: 0
    },
    current: {
      all_today: 0,
      done_today: 0,
      all_week: 0,
      done_week: 0,
      all_goal: 0,
      done_goal: 0
    },
  },
  mutations: {
    updateStarsStatistics(state, values) {
      state.stars.all           = values.all,
      state.stars.current_year  = values.current_year,
      state.stars.current_month = values.current_month,
      state.stars.current_week  = values.current_week,
      state.stars.current_day   = values.today
    }
  },
  actions:   {}
}