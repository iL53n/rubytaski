import Vue  from 'vue'
import Vuex from 'vuex'
import VuexPersistedState from 'vuex-persistedstate'

Vue.use(Vuex)

import statistics from './modules/statistics'

export default new Vuex.Store({
  state:     {
    currentUser: null
  },
  mutations: {
    updateCurrentUser(state, value) {
      state.currentUser = value
    }
  },
  actions:   {},
  modules:   {
    statistics
  },
  plugins:   [
    VuexPersistedState()
  ]
})