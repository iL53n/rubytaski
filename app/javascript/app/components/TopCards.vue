<template lang="pug">
  .desktop-only
    div(v-if="loading")
      q-page-container(align="middle")
        q-spinner-dots(color="primary" size="lg")
    div(v-else-if="error")
      .text-h5.text-red ERROR!
      .text-h3.text-black Try to reload the page!
    div(v-else)
      .row.justify-around(v-if="stat.tasks.all_active")
        //- DAY progress Card
        q-card.col.q-ma-md
          q-card-section
            .row
              .col.text-grey(align="left")
                q-icon(name="event" color="primary" size="sm")
              .col.text-subtitle1.text-grey.ellipsis(align="right") {{ $t('stat.today') }}
            q-separator
            br
            div(v-if="leftToCompleteDay")
              br
              q-slider(
                v-model="stat.stars.current_day"
                :min="0"
                :max="stat.tasks.all_active"
                readonly
                label
                :label-value="leftToCompleteDay + $t('stat.left_to_complete')"
                label-always
                color="orange-4"
              )
              .text-h4.text-blue-grey-14 {{stat.stars.current_day}}/{{stat.tasks.all_active}}
            div(v-else)
              q-btn.shine.text-yellow-2.bg-amber-5(push glossy round padding="xs" size="60px" icon="verified")
                q-tooltip(class="bg-primary" :offset="[10, 10]" :delay="200")
                  .text-h5 {{stat.stars.current_day}}/{{stat.tasks.all_active}}
        //- WEEK progress Card
        q-card.col.q-ma-md
          q-card-section
            .row
              .col.text-grey(align="left")
                q-icon(name="calendar_view_week" color="primary" size="sm")
              .col.text-subtitle1.text-grey.ellipsis(align="right") {{ $t('stat.week') }}
            q-separator
            br
            div(v-if="leftToCompleteWeek")
              q-linear-progress(size="60px" :value="weekProgress / 100" color="green-4")
                .absolute-full.flex.flex-center
                  q-badge(color="white" text-color="green")
                    | {{  weekProgress }}%
              .text-h4.text-blue-grey-14 {{stat.stars.current_week}}/{{stat.tasks.all_active * 7}}
            div(v-else)
              q-btn.text-yellow-2.bg-amber-5(push glossy round padding="xs" size="60px" icon="emoji_events")
                q-tooltip(class="bg-primary" :offset="[10, 10]" :delay="200")
                  .text-h5 {{stat.stars.current_week}}/{{stat.tasks.all_active * 7}}
        //- GOAL Card
        q-card.col.q-ma-md
          q-card-section
            .row
              .col.text-grey(align="left")
                q-icon(name="track_changes" color="primary" size="sm")
              .col.text-subtitle1.text-grey.ellipsis(align="right") {{ $t('stat.goal') }}
            q-separator
            br
            q-card-section(v-if="goal.due_date" horizontal)
              //- why don't work `>=` ?
              q-knob.col.text-blue-grey-14(
                v-if="leftToCompleteGoal > 0"
                readonly
                v-model="goalProgress"
                show-value
                size="105px"
                :thickness="0.22"
                color="red-4"
                track-color="grey-3"
                )
                .text-h4 {{ goalProgress }}
                .text-h6.text-grey %
              .col(v-else)
                q-btn.shine.text-yellow-2.bg-amber-5(push glossy round padding="xs" size="60px" icon="emoji_events")
              q-separator(vertical)
              q-list.col.text-blue-grey-6(align="left" dense padding)
                q-item
                  q-icon(name="date_range" size="sm" color="teal-4" left)
                  div {{ goal.due_date }}
                q-item
                  q-icon(name="stars" size="sm" color="amber-4" left)
                  div {{ this.stat.goals.current.completed_stars }}/{{ this.stat.goals.current.number_of_stars }}
                q-item
                  q-icon(name="emoji_events" size="sm" color="red-4" left)
                  div.ellipsis {{ goal.prize }}
            //- NO GOAL
            q-card-section(v-else horizontal)
              .col-9
                q-card-section
                  .text-h6.text-red-5 У вас нет ни одной активной цели!
                  .text-caption.text-blue-grey-8 Создайтие новую цель, кликнув на иконку.
              .col-3
                q-card-section
                  q-btn.text-red-4.bg-red-1(size="25px" flat round icon="add" @click="newGoal()")
      div(v-else)
        //- NO TASKS
        q-card.col.q-ma-md
          q-card-section
            .row
              .col.text-grey(align="left")
                q-icon(name="playlist_add" color="red-4" size="sm")
              .col.text-subtitle1.text-grey(align="right") {{ $t('tasks.title') }}
            q-separator
            br
            q-card-section(horizontal)
              .col-4
              .col-3
                q-card-section
                  .text-h6.text-red-5 У вас нет ни дной задачи!
                  .text-caption.text-blue-grey-8 Создайтие новую задачу, кликнув на иконку.
              .col-1
                q-card-section
                  q-btn.text-red-4.bg-red-1(size="25px" flat round icon="add" @click="newTask()")
              .col-4
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
.shine:after {
    content: "";
    height: 200%;
    left: -200%;
    opacity: 0;
    position: absolute;
    top: -20%;
    transform: rotate(-30deg);
    width: 200%;
  opacity: 1;
  background: rgba(255, 255, 255, 0.13);
  background: linear-gradient(
    to right, 
    /*rgba(255, 255, 255, 0.13) 0%,*/
    rgba(255, 255, 255, 0.0) 0%,
    rgba(255, 255, 255, 0.13) 77%,
    rgba(255, 255, 255, 0.5) 92%,
    rgba(255, 255, 255, 0.0) 100%
  );
  animation: 10s anim linear 3s infinite;
}

@keyframes anim {
  0% {
     left: -200%;
     top: -20%;
  }
  5% {
    left: -50%;
    top: -50%;
  }
  10% {
     left: -200%;
     top: -20%;
  }
  100% {
  /* delay */
  }
}
</style>
