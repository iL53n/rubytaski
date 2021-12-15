import Vue       from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

import Tasks      from 'components/tasks/Index.vue'
import Task       from 'components/tasks/Show.vue'
import Goals      from 'components/goals/Index.vue'
import Goal       from 'components/goals/Show.vue'
import Dashboard  from 'components/Dashboard.vue'

export default new VueRouter ({
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/',          redirect: '/dashboard' },
    { path: '/tasks',     component: Tasks,
      children: [
        { path: ':id/', component: Task }
      ]
    },
    { path: '/goals',     component: Goals,
      children: [
        { path: ':id/', component: Goal }
      ]
    },
    { path: '/dashboard', component: Dashboard }
  ]
})