import Vue       from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const Tasks      = () => import(/* webpackChunkName: "tasks" */ 'components/tasks/Index')
const Task       = () => import(/* webpackChunkName: "dashboard" */ 'components/tasks/Show')
const NewTask    = () => import(/* webpackChunkName: "tasks" */ 'components/tasks/New')
const EditTask   = () => import(/* webpackChunkName: "tasks" */ 'components/tasks/Edit')
const Goals      = () => import(/* webpackChunkName: "goals" */ 'components/goals/Index')
const Goal       = () => import(/* webpackChunkName: "goals" */ 'components/goals/Show')
const NewGoal    = () => import(/* webpackChunkName: "goals" */ 'components/goals/New')
const EditGoal   = () => import(/* webpackChunkName: "goals" */ 'components/goals/Edit')
const DoneGoal   = () => import(/* webpackChunkName: "goals" */ 'components/goals/Done')
const Dashboard  = () => import(/* webpackChunkName: "dashboard" */ 'components/Dashboard')
const Statistics = () => import(/* webpackChunkName: "statistics" */ 'components/Statistics')
const Profile    = () => import(/* webpackChunkName: "profile" */ 'components/Profile')

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
        { path: ':id/done/', component: DoneGoal, name: 'doneGoal' },
        { path: ':id/', component: Goal, name: 'showGoal' }
      ]
    },
    { path: '/dashboard', component: Dashboard,
    children: [
      { path: ':id/', component: Task, name: 'dashboardShowTask' },
      { path: 'new_goal/', component: NewGoal, name: 'dashboardNewGoal' },
      { path: 'new_task/', component: NewTask, name: 'dashboardNewTask' }
    ]
    },
    { path: '/statistics', component: Statistics },
    { path: '/profile', component: Profile }
  ]
})