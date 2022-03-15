import Vue  from 'vue'
import Vuex from 'vuex'
import VuexPersistedState from 'vuex-persistedstate'

Vue.use(Vuex)

import statistics from './modules/statistics'

export default new Vuex.Store({
  state:     {
    currentUser: null,
    miniStateRight: false
  },
  mutations: {
    updateCurrentUser(state, value) {
      state.currentUser = value
    },
    updateMiniStateRight(state, value) {
      state.miniStateRight = value
    },
    updateAllStatistics(state, values) {
      state.statistics = values
    },
  },
  actions:   {},
  modules:   {
    statistics
  },
  plugins:   [
    VuexPersistedState()
  ]
})