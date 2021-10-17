<template lang="pug">
  div
    q-page-container(align="middle")
      //q-toolbar(class="bg-green-3")
      //  q-toolbar-title(align="middle") #моянеделя
      div(class="q-pa-md row justify-around")
        q-card
          q-card-section
            // weekdays=[0,1,2,3,4,5,6,7]
            q-calendar(
              ref="calendar"
              v-model="selectedDate"
              view="week-scheduler"
              :resources="resources"
              resource-key="id"
              :resource-width="500"
              locale="ru"
              style="height: 100%;"
            )
              template(#scheduler-resources-header)
                div(class="full-height row justify-center items-center")
                  q-btn(flat color="white" text-color="grey" icon="keyboard_arrow_left" @click="calendarPrev")
                  q-btn(flat color="white" text-color="grey" icon="more_horiz" @click="calendarToday")
                  q-btn(flat color="white" text-color="grey" icon="keyboard_arrow_right" @click="calendarNext")
              template(#scheduler-resource="{ resource /*, index */ }")
                div(class="col-12")
                  q-btn(flat class="fit" size="xl")
                    div(class="ellipsis") {{ resource.attributes.title }}
              template(#scheduler-resource-day="{ timestamp, /* index, */ resource }")
                q-btn(flat class="fit" @click="addStar(resource.id, timestamp.date)")
                  div(v-for="star in resource.attributes.stars_dates" :key="star.id")
                    div(v-if="star.due_date == timestamp.date")
                      q-btn(
                        v-if="star.state == 'planned'"
                        push
                        round
                        padding="xs"
                        class="fit"
                        align="around"
                        name="star"
                        text-color="yellow"
                        size="30px"
                        icon="star_border"
                        @click="doneStar()"
                      )
                      q-btn(
                        v-else-if="star.state == 'done'"
                        push
                        round
                        padding="xs"
                        class="fit"
                        align="around"
                        name="star"
                        color="light-blue-9"
                        text-color="yellow"
                        size="30px"
                        icon="star"
                        @click="undoneStar()"
                      )
                    //div(v-else)
                    //  q-btn(
                    //    flat
                    //    round
                    //    padding="xs"
                    //    align="around"
                    //    class="fit"
                    //    name="star"
                    //    text-color="grey"
                    //    size="15px"
                    //    icon="star_border"
                    //    @click=""
                    //  )
</template>

<script>
  import { getTasks, postStar } from '../api'

  export default {
    data () {
      return {
        selectedDate: '',
        resources: this.getTasks(),
      }
    },
    methods: {
      getTasks() {
        getTasks()
          .then((response) => {
            this.resources = response.data.data
        })
      },
      addStar(task_id, date) {
        postStar({ state: 1, task_id: task_id, due_date: date })
        .then((response) => {
          this.getTasks()
        })
      },
      doneStar() {
        console.log('done_star')
      },
      undoneStar() {
        console.log('undone_star')
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
    components: {}
  }
</script>