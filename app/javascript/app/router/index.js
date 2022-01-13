import Vue       from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const Tasks      = () => import(/* webpackChunkName: "tasks" */ 'components/tasks/Index')
const Task       = () => import(/* webpackChunkName: "tasks" */ 'components/tasks/Show')
const NewTask    = () => import(/* webpackChunkName: "tasks" */ 'components/tasks/New')
const EditTask   = () => import(/* webpackChunkName: "tasks" */ 'components/tasks/Edit')
const Goals      = () => import(/* webpackChunkName: "goals" */ 'components/goals/Index')
const Goal       = () => import(/* webpackChunkName: "goals" */ 'components/goals/Show')
const NewGoal    = () => import(/* webpackChunkName: "goals" */ 'components/goals/New')
const EditGoal   = () => import(/* webpackChunkName: "goals" */ 'components/goals/Edit')
const Dashboard  = () => import(/* webpackChunkName: "dashboard" */ 'components/Dashboard')
const Statistics = () => import(/* webpackChunkName: "statistics" */ 'components/Statistics')

export default new VueRouter ({
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/', redirect: '/dashboard' },
    { path: '/tasks_list', component: Tasks,
      children: [
        { path: 'new/', component: NewTask, name: 'newTask' },
        { path: ':id/edit/', component: EditTask, name: 'editTask' },
        { path: ':id/', component: Task, name: 'showTask' }
      ]
    },
    { path: '/goals_list', component: Goals,
      children: [
        { path: 'new/', component: NewGoal, name: 'newGoal' },
        { path: ':id/edit/', component: EditGoal, name: 'editGoal' },
        { path: ':id/', component: Goal, name: 'showGoal' }
      ]
    },
    { path: '/dashboard', component: Dashboard,
    children: [
      { path: ':id/', component: Task, name: 'dashboardShowTask' }
    ]
    },
    { path: '/statistics', component: Statistics }
  ]
})