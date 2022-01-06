<template lang="pug">
  div
    div(v-if="loading")
      q-page-container(align="middle")
        q-spinner-dots(color="primary" size="lg")
    //- q-toolbar(class="bg-green-3")
      //- q-toolbar-title(align="middle") #моянеделя
    div(v-else-if="error")
      .text-h3.text-red ERROR!
    div(v-else)
      div(class="row justify-around")
        general-stat
        q-card(class="col-grow q-ma-lg")
          q-card-section
            // weekdays=[0,1,2,3,4,5,6,7]
            q-calendar(
              ref="calendar"
              v-model="selectedDate"
              view="week-scheduler"
              :resources="resources.schedule.data"
              resource-key="id"
              :resource-width="550"
              :resource-height="0"
              locale="en"
              style="height: 100%;"
              :weekdays=[1, 2, 3, 4, 5, 6, 0]
            )
              template(#scheduler-resources-header)
                div(class="full-height row justify-center items-center")
                  q-btn-group(outline)
                    q-btn(flat color="white" size="sm" text-color="grey" icon="keyboard_arrow_left" @click="calendarPrev")
                    q-btn(flat color="white" size="sm" text-color="grey" icon="more_horiz" @click="calendarToday")
                    q-btn(flat color="white" size="sm" text-color="grey" icon="keyboard_arrow_right" @click="calendarNext")
              template(#scheduler-resource="{ resource /*, index */ }")
                div(class="col-12")
                  q-btn(@click="showTask(resource.id)" flat class="fit" size="lg")
                    div(class="ellipsis") {{ resource.title }}
              template(#scheduler-resource-day="{ timestamp, /* index, */ resource }")
                q-btn(flat class="fit" @click.stop="addStar(resource.id, timestamp.date)")
                  div(v-for="star in resource.stars_dates" :key="star.id")
                    div(v-show="star.due_date == timestamp.date")
                      //star options: stars, verified, check_circle, task_alt
                      q-btn(
                        push
                        glossy
                        round
                        padding="xs"
                        class="fit"
                        align="around"
                        name="star"
                        color="amber-5"
                        text-color="yellow-2"
                        size="25px"
                        icon="star"
                        @click.stop="removeStar(star.id)"
                      )
</template>

<script>
  import generalStat from 'components/GeneralStat'
  import loadingMixin from 'mixins'

  export default {
    data () {
      return {
        selectedDate: '',
        resources: {
          schedule: {
            data: []
          }
        }
      }
    },
    computed: {
      stats: {
        get () {
          return this.$store.state.statistics.stars
        },
        set (values) {
          this.$store.commit('updateStarsStatistics', values)
        }
      }
    },
    created() {
      this.getTasks(),
      this.getStatistics()
    },
    methods: {
      getTasks() {
        this.$backend.tasks.index()
          .then((response) => this.resources = response.data)
          .catch(()        => this.error = true)
          .finally(()      => this.loading = false)
      },
      showTask(task_id) {
        this.$router.push({ name: 'dashboardShowTask', params: { id: task_id } })
      },
      addStar(task_id, date) {
        let params = { state: 1, task_id: task_id, due_date: date }

        this.$backend.stars.create(params)
          .then((response) => {
            this.getTasks()
            this.getStatistics()
            // this.$emit('add-star')
          })
          .catch(()   => this.error = true)
          .finally(() => this.loading = false)
      },
      removeStar(id) {
        this.$backend.stars.destroy(id)
          .then((response) => {
            this.getTasks()
            this.getStatistics()
          })
          .catch(()   => this.error = true)
          .finally(() => this.loading = false)
      },
      getStatistics() {
        this.$backend.statistics.stars()
          .then((response) => {
            this.stats = response.data
          })
          .catch(()   => this.error = true)
          .finally(() => this.loading = false)
      },
      calendarNext () {
        this.$refs.calendar.next()
      },
      calendarToday () {
        this.selectedDate = ''
      },
      calendarPrev () {
        this.$refs.calendar.prev()
      },
    },
    mixins: [loadingMixin],
    components: {
      generalStat
    }
  }
</script>