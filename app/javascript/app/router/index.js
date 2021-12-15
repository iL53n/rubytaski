import Vue       from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

import Tasks      from 'components/tasks/Index.vue'
import Task       from 'components/tasks/Show.vue'
import NewTask    from 'components/tasks/New.vue'
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
        { path: 'new/', component: NewTask, name: 'newTask' },
        { path: ':id/', component: Task, name: 'showTask' }
      ]
    },
    { path: '/goals',     component: Goals,
      children: [
        { path: ':id/', component: Goal, name: 'showGoal' }
      ]
    },
    { path: '/dashboard', component: Dashboard,
    children: [
      { path: ':id/', component: Task, name: 'dashboardShowTask' },
      { path: 'new/', component: NewTask, name: 'dashboardNewTask' } //del
    ]
  }
  ]
})