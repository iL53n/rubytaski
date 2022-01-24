<template lang="pug">
  div
    div(v-if="loading")
      q-page-container(align="middle")
        q-spinner-dots(color="primary" size="lg")
    div(v-else-if="error")
      .text-h3.text-red ERROR!
    div(v-else)
      div(class="row no-wrap justify-between")
        q-card(class="col-2 q-ma-md gradient")
          q-card-section
            general-stat
        q-card(class="col q-ma-md")
          q-toolbar(class="text-white gradient" align="right")
            q-btn-group(flat)
              q-btn(size="sm" icon="keyboard_arrow_left" @click="calendarPrev")
              q-btn(size="sm" icon="horizontal_rule" @click="calendarToday")
              q-btn(size="sm" icon="keyboard_arrow_right" @click="calendarNext")
            q-toolbar-title {{ titleDate }}
          q-card-section
            q-calendar(
              ref="calendar"
              v-model="selectedDate"
              no-active-date
              v-touch-swipe.mouse.left.right="handleSwipe"
              view="week-scheduler"
              :resources="resources.schedule.data"
              resource-key="id"
              :resource-width="400"
              :resource-height="0"
              cell-width="auto"
              :locale="locale"
              style="height: 100%;"
              :weekdays=[1, 2, 3, 4, 5, 6, 0]
              @change="onChange"
            )
              //- template(#scheduler-resources-header)
                //- div(class="full-height row justify-center items-center")
                  //- div(class="text-h6") {{ titleDate }}
              template(#scheduler-resource="{ resource /*, index */ }") 
                q-btn(@click="showTask(resource.id)" flat size="lg" class="full-width" align="left")
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
                        class="fit emergence"
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

  // TODO: remove it (DRY)
  import QCalendar from '@quasar/quasar-ui-qcalendar'

  export default {
    data () {
      return {
        selectedDate: '',
        titleDate: '',
        dateFormatter: undefined,
        start: undefined,
        locale: this.$i18n.locale,
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
    beforeMount () {
      this.refresh()
      this.updateFormatter()
    },
    watch: {
      locale () {
        // this.updateFormatter()
        this.updateTitle()
      }
    },
    methods: {
      onChange ({ start }) {
        this.start = start
        this.updateTitle()
      },
      refresh() {
        this.getTasks(),
        this.getStatistics()
      },
      getTasks() {
        this.$backend.tasks.index()
          .then((response) => this.resources = response.data)
          .catch(()        => this.error = true)
          .finally(()      => {
            // this.loading = false
          })
      },
      showTask(task_id) {
        this.$router.push({ name: 'dashboardShowTask', params: { id: task_id } })
      },
      addStar(task_id, date) {
        let params = { state: 1, task_id: task_id, due_date: date }

        this.$backend.stars.create(params)
          .then((response) => {
            this.refresh()
            // this.$emit('add-star')
          })
          .catch(()   => this.error = true)
          .finally(() => this.loading = false)
      },
      removeStar(id) {
        this.$backend.stars.destroy(id)
          .then((response) => {
            this.refresh()
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
      handleSwipe ({ evt, ...info }) {
        if (info.duration >= 30) {
          if (info.direction === 'right') {
            this.calendarPrev()
          } else if (info.direction === 'left') {
            this.calendarNext()
          }
        }
        evt.cancelable !== false && evt.preventDefault()
        evt.stopPropagation()
      },
      updateTitle () {
        const myDate = QCalendar.makeDate(this.start)

        if (this.dateFormatter !== undefined) {
          this.titleDate = this.dateFormatter.format(myDate)
        }
      },
      updateFormatter () {
        try {
          this.dateFormatter = new Intl.DateTimeFormat(this.locale || undefined, {
            month: 'long',
            year: 'numeric',
            timeZone: 'UTC'
          })
        }
        catch (e) {
          // console.error('Intl.DateTimeFormat not supported')
          this.dateFormatter = undefined
        }
      }
    },
    mixins: [loadingMixin],
    components: {
      generalStat
    },
    subscriptions: {
      StarsChannel: {
        received(data) {
          this.refresh()
        }
      }
    }
  }
</script>

<style scoped>
.gradient {
  background: linear-gradient(90deg, #847bf3 0%, #b47bf3 100%);
}

.emergence { 
    animation: emergence-with-rotate 0.8s;
    animation-iteration-count: 1;
}

@keyframes emergence-with-rotate {
  0% {
    transform: rotate(0deg) scale(0.5);
  }
  60% {
    transform: 
    rotate(360deg) scale(1);
  }
  80% {
    transform: scale(1.2);
  }
  90% {
    transform: scale(1.1);
  }
  100% {
    transform: scale(1);
  }
}
</style>