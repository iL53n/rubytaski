<template lang="pug">
.row.justify-around(v-if="stat.tasks.all_active")
  q-card.col.q-ma-md.zoom-box
    q-list(dense)
      q-item
        q-item-section(avatar)
          .text-subtitle1.text-grey.ellipsis Today
        q-item-section
          q-slider(
            v-model="stat.stars.current_day"
            :min="0"
            :max="stat.tasks.all_active"
            readonly
            label
            :label-value="this.stat.stars.current_day + '/' + this.stat.tasks.all_active "
            color="blue-4"
          )
      q-item
        q-item-section(avatar)
          .text-subtitle1.text-grey.ellipsis Week
        q-item-section
          q-slider(
            v-model="stat.stars.current_week"
            :min="0"
            :max="stat.tasks.all_active * 7"
            readonly
            label
            :label-value="this.stat.stars.current_week + '/' + this.stat.tasks.all_active * 7"
            color="green-4"
          )
      q-item
        q-item-section(avatar)
          .text-subtitle1.text-grey.ellipsis Goal
        q-item-section
          q-slider(
            v-model="goalProgress"
            :min="0"
            :max="this.stat.goals.current.number_of_stars"
            readonly
            :label-value="this.stat.goals.current.completed_stars + '/' + this.stat.goals.current.number_of_stars"
            color="red-4"
          )

</template>

<script>
  import loadingMixin from 'mixins'

  export default {
    data () {
      return {
        goal: {}
      }
    },
    computed: {
      stat: {
        get() {
          return this.$store.state.statistics
        },
        set(value) {
          this.$store.commit('updateAllStatistics', value)
        }
      },
      weekProgress() {
        return Math.round( this.stat.stars.current_week / (this.stat.tasks.all_active * 7) * 100)
      },
      leftToCompleteDay() {
        return this.stat.tasks.all_active - this.stat.stars.current_day
      },
      leftToCompleteWeek() {
        return (this.stat.tasks.all_active * 7) - this.stat.stars.current_week
      },
      leftToCompleteGoal() {
        return this.stat.goals.current.number_of_stars - this.stat.goals.current.completed_stars
      },
      goalProgress() {
        return Math.round(this.stat.goals.current.completed_stars / this.stat.goals.current.number_of_stars * 100)
      }
    },
    created () {
      this.getStatistics()
    },
    methods: {
      getStatistics() {
        this.$backend.statistics.index({ scopes: 'general_stat,tasks_stat,goals_stat,stars_stat' })
          .then((response) => {
            this.stat = response.data.stat
          })
          .catch(()   => this.error = true)
          .finally(() => {
            if (this.stat.goals.current.id) {
              this.getGoal()
            } else {
              this.loading = false
            }
          })
      },
      getGoal() {
        this.$backend.goals.show(this.stat.goals.current.id)
          .then((response) => {
            this.goal = response.data.goal
          })
          .catch(()   => this.error = true)
          .finally(() => this.loading = false)
      },
      newGoal() {
        this.$router.push({ name: 'dashboardNewGoal' })
      },
      newTask() {
        this.$router.push({ name: 'dashboardNewTask' })
      },
    },
    mixins: [loadingMixin],
    subscriptions: {
      TasksChannel: {
        received(data) {
          this.getStatistics()
        }
      },
      GoalsChannel: {
        received(data) {
          this.getStatistics()
        }
      }
    }
  }
</script>

<style scoped>
.zoom-box {
  transition: transform .4s; /* Animation */
}

.zoom-box:hover {
  transform: scale(1.02);
}
</style>
