<template lang="pug">
  div(class="desktop-only")
    div(v-if="loading")
      q-page-container(align="middle")
        q-spinner-dots(color="primary" size="lg")
    div(v-else-if="error")
      .text-h3.text-red ERROR!
    div(v-else)
      div(v-if="stat.all_today" class="row justify-around")
        //- DAY preogress Card
        q-card(class="col q-ma-md")
          q-card-section
            div(class="row")
              div(class="col text-grey" align="left")
                q-icon(name="event" color="primary" size="sm")
              div(class="col text-subtitle1 text-grey" align="right") {{ $t('stat.today') }}
            q-separator
            br
            div(v-if="leftToCompleteDay")
              br
              q-slider(
                v-model="stat.done_today"
                :min="0"
                :max="stat.all_today"
                readonly
                label
                :label-value="leftToCompleteDay + $t('stat.left_to_complete')"
                label-always
                color="orange-4"
              )
              div(class="text-h3 text-blue-grey-14") {{stat.done_today}}/{{stat.all_today}}
            div(v-else)
              q-btn(push glossy round class="text-yellow-2 bg-amber-5" padding="xs" size="60px" icon="emoji_events")
                .text-h4.text-blue-grey-14.absolute {{stat.done_today}}/{{stat.all_today}}
        //- WEEK progress Card
        q-card(class="col q-ma-md")
          q-card-section
            div(class="row")
              div(class="col text-grey" align="left")
                q-icon(name="calendar_view_week" color="primary" size="sm")
              div(class="col text-subtitle1 text-grey" align="right") {{ $t('stat.week') }}
            q-separator
            br
            q-linear-progress(size="60px" :value="weekProgress / 100" color="green-4")
              div(class="absolute-full flex flex-center")
                q-badge(color="white" text-color="green")
                  | {{  weekProgress }}%
            div(class="text-h3 text-blue-grey-14") {{stat.done_week}}/{{stat.all_week}}
        //- GOAL Card
        q-card(class="col q-ma-md")
          q-card-section
            div(class="row")
              div(class="col text-grey" align="left")
                q-icon(name="track_changes" color="primary" size="sm")
              div(class="col text-subtitle1 text-grey" align="right") {{ $t('stat.goal') }}
            q-separator
            br
            q-card-section(v-if="goal.due_date" horizontal)
              q-knob(
                readonly
                v-model="goalProgress"
                show-value
                size="105px"
                :thickness="0.22"
                color="red-4"
                track-color="grey-3"
                class="text-blue-grey-14 col"
                )
                div(class="text-h3") {{ goalProgress }}
                div(class="text-h6 text-grey") %
              q-separator(vertical)
              q-list(class="col-5 text-blue-grey-6" align="left" dense)
                q-item
                  q-item-section(avatar)
                    q-icon(name="date_range" color="teal-4")
                  q-item-section {{ goal.due_date }}
                q-item
                  q-item-section(avatar)
                    q-icon(name="stars" color="amber-4")
                  q-item-section {{ this.stat.done_goal }}/{{ this.stat.all_goal }}
                q-item
                  q-item-section(avatar)
                    q-icon(name="emoji_events" color="red-4")
                  q-item-section {{ goal.prize }}
            //- NO GOAL
            q-card-section(v-else horizontal)
              .col-9
                q-card-section
                  .text-h6.text-red-5 У вас нет ни одной активной цели!
                  .text-caption.text-blue-grey-8 Создайтие новую цель, кликнув на иконку.
              .col-3
                q-card-section
                  q-btn(size="25px" class="text-red-4 bg-red-1" flat round icon="add" @click="newGoal()")
      div(v-else)
        //- NO TASKS
        q-card(class="col q-ma-md")
          q-card-section
            div(class="row")
              div(class="col text-grey" align="left")
                q-icon(name="add_task" color="red-5" size="sm")
              div(class="col text-subtitle1 text-grey" align="right") {{ $t('tasks.title') }}
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
                  q-btn(size="25px" class="text-red-4 bg-red-1" flat round icon="add" @click="newTask()")
              .col-4
</template>

<script>
  import loadingMixin from 'mixins'

  export default {
    data () {
      return {
        stat: {},
        goal: {}
      }
    },
    computed: {
      starsStats() {
        return this.$store.state.statistics.stars.all
      },
      weekProgress() {
        return Math.round(this.stat.done_week / this.stat.all_week * 100)
      },
      leftToCompleteDay() {
        return this.stat.all_today - this.stat.done_today
      },
      goalProgress() {
        return Math.round(this.stat.done_goal / this.stat.all_goal * 100)
      }
    },
    created () {
      this.getStatistics()
    },
    watch: {
      starsStats() {
        this.getStatistics()
      }
    },
    methods: {
      getStatistics() {
        this.$backend.statistics.current()
          .then((response) => {
            this.stat = response.data       
          })
          .catch(()   => this.error = true)
          .finally(() => {
            if (this.stat.goal_id) {
              this.getGoal()
            } else {
              this.loading = false
            }
          })
      },
      getGoal() {
        this.$backend.goals.show(this.stat.goal_id)
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
    mixins: [loadingMixin]
  }
</script>

<style scoped></style>
