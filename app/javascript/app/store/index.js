import Vue  from 'vue'
import Vuex from 'vuex'
import VuexPersistedState from 'vuex-persistedstate'

Vue.use(Vuex)

import statistics from './modules/statistics'

export default new Vuex.Store({
  state:     {},
  mutations: {},
  actions:   {},
  modules:   {
    statistics
  },
  plugins:   [
    VuexPersistedState()
  ]
})