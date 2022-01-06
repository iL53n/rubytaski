<template lang="pug">
  div(class="row justify-around")
    q-card(class="col q-ma-lg")
      q-card-section
        div(class="row")
          div(class="col text-grey" align="left")
            q-icon(name="event" color="primary" size="sm")
          div(class="col text-subtitle1 text-grey" align="right") Today
        q-separator
        br
        div(v-if="leftToCompleteDay >= 0")
          br
          q-slider(
            v-model="stat.done_today"
            :min="0"
            :max="stat.all_today"
            readonly
            label
            :label-value="leftToCompleteDay + ' left to complete'"
            label-always
            color="orange-4"
          )
          div(class="text-h3 text-blue-grey-14") {{stat.done_today}}/{{stat.all_today}}
        div(v-else)
          br
          q-chip(size="xl" outline color="blue-grey-4" icon="warning_amber") No information
    q-card(class="col q-ma-lg")
      q-card-section
        div(class="row")
          div(class="col text-grey" align="left")
            q-icon(name="calendar_view_week" color="primary" size="sm")
          div(class="col text-subtitle1 text-grey" align="right") Week
        q-separator
        br
        div(v-if="weekProgress >= 0")
          q-linear-progress(size="60px" :value="weekProgress / 100" color="green-4")
            div(class="absolute-full flex flex-center")
              q-badge(color="white" text-color="green")
                | {{  weekProgress }}%
          div(class="text-h3 text-blue-grey-14") {{stat.done_week}}/{{stat.all_week}}
        div(v-else)
          br
          q-chip(size="xl" outline color="blue-grey-4" icon="warning_amber") No information
    q-card(class="col q-ma-lg")
      q-card-section
        div(class="row")
          div(class="col text-grey" align="left")
            q-icon(name="track_changes" color="primary" size="sm")
          div(class="col text-subtitle1 text-grey" align="right") Goal
        q-separator
        br
        q-knob(
          v-if="goalProgress >= 0"
          readonly
          v-model="goalProgress"
          show-value
          size="105px"
          :thickness="0.22"
          color="red-4"
          track-color="grey-3"
          class="text-blue-grey-14"
        )
          div(class="text-h3") {{  goalProgress }}
          div(class="text-h6 text-grey") %
        div(v-else)
          br
          q-chip(size="xl" outline color="blue-grey-4" icon="warning_amber") No information
</template>

<script>
  export default {
    data () {
      return {
        stat: {},
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
            console.log(this.stat)
          })
          .catch(()   => this.error = true)
          .finally(() => this.loading = false)
      },
    }
  }
</script>

<style scoped></style>
