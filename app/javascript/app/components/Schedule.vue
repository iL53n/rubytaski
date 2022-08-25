<template lang="pug">
  div
    div(v-if="loading")
      q-page-container(align="middle")
        q-spinner-dots(color="primary" size="lg")
    div(v-else-if="error")
      .text-h3.text-red ERROR!
    div(v-else)
      div(class="row no-wrap justify-between")
        q-card(class="col-2 q-ma-md gradient desktop-only")
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
            //- v-touch-swipe.mouse.left.right="handleSwipe"
            //- short-weekday-label?
            // TODO: fix resource-width
            q-calendar(
              ref="calendar"
              v-model="selectedDate"
              no-active-date
              short-weekday-label
              view="week-scheduler"
              :resources="resources.schedule.data"
              resource-key="id"
              :resource-width="this.$q.screen.width * 0.28"
              :resource-height="0"
              sticky
              cell-width="auto"
              :locale="locale"
              animated
              transition-prev="slide-right"
              transition-next="slide-left"
              style="height: 100%"
              :weekdays=[1, 2, 3, 4, 5, 6, 0]
              @change="onChange"
            )
              template(#scheduler-resources-header)
                //- div(class="full-height row justify-center items-center")
                //-   div(class="text-h6") {{ titleDate }}
                div(class="col-auto")
                  q-btn(color="grey-4" round flat icon="tune")
                    q-menu(cover auto-close)
                      q-list
                        q-item(clickable to="/tasks_list" class="text-primary")
                          q-item-section Настроить список задач
              template(#scheduler-resource="{ resource /*, index */ }") 
                q-btn(@click="showTask(resource.id)" flat size="lg" class="full-width" align="left")
                  div(class="ellipsis") {{ resource.title }}
                q-tooltip(class="bg-primary" :delay="700") 
                 .text-subtitle1 {{ resource.title }}
                 .text-subtitle2 {{ resource.description }}
              template(#scheduler-resource-day="{ timestamp, /* index, */ resource }")
                q-btn(flat class="fit" @click="addStar(resource.id, timestamp.date)")
                  div(v-for="star in resource.stars_dates" :key="star.id")
                    div(v-show="star.due_date == timestamp.date")
                      //star options: stars, verified, check_circle, task_alt
                      q-btn(
                        push
                        glossy
                        round
                        padding="xs"
                        class="fit emergence zoom-box"
                        align="around"
                        name="star"
                        color="amber-5"
                        text-color="yellow-2"
                        size="lg"
                        icon="star"
                        @click.stop="removeStar(star.id)"
                      )
    router-view
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
      goal_stat: {
        get () {
          // return this.$store.state.statistics.goals
        },
        set (values) {
          this.$store.commit('updateGoalsStatistics', values)
        }
      },
      stat: {
        get () {
          return this.$store.state.statistics.stars
        },
        set (values) {
          this.$store.commit('updateStarsStatistics', values)
        }
      },
      heatmap: {
        get () {
          // return this.$store.state.statistics.heatmap
        },
        set (values) {
          this.$store.commit('updateHeatmapStatistics', values)
        }
      }
    },
    created () {
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
        this.$backend.tasks.indexCreated({ scopes: 'created' })
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
            // this.refresh()
            // this.$emit('add-star')
          })
          .catch(()   => this.error = true)
          .finally(() => this.loading = false)
      },
      removeStar(id) {
        this.$backend.stars.destroy(id)
          .then((response) => {
            // this.refresh()
          })
          .catch(()   => this.error = true)
          .finally(() => this.loading = false)
      },
      getStatistics() {
        this.$backend.statistics.index({ scopes: 'stars_stat,goals_stat,heatmap_chart' })
          .then((response) => {
            this.stat = response.data.stat.stars
            this.goal_stat = response.data.stat.goals
            this.heatmap = response.data.stat.heatmap
          })
          .catch(()   => this.error = true)
          .finally(() => { 
            // this.loading = false 
          })
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
      },
      TasksChannel: {
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
  50% {
    transform: 
    rotate(360deg) scale(1);
  }
  65% {
    transform: scale(1.1);
  }
  80% {
    transform: scale(1.2);
  }
  100% {
    transform: scale(1.1);
  }
}

.zoom-box {
  transition: transform .4s; /* Animation */
}

.zoom-box:hover {
  transform: scale(1.1);
}
</style>