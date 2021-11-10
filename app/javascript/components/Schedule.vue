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
              :resource-width="550"
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
                    q-btn(
                      name="delete"
                      flat
                      round
                      color="white"
                      text-color="negative"
                      size="15px"
                      icon="clear"
                      @click="removeTask(resource)"
                      method="delete"
                    )
              template(#scheduler-resource-day="{ timestamp, /* index, */ resource }")
                q-btn(flat class="fit" @click.stop="addStar(resource.id, timestamp.date)")
                  div(v-for="star in resource.attributes.stars_dates" :key="star.id")
                    div(v-show="star.due_date == timestamp.date")
                      //star options: stars, verified, check_circle, task_alt
                      q-btn(
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
                        @click.stop="removeStar(star.id)"
                      )
                    // ToDo: template for 3 states
                    //div(v-if="star.due_date == timestamp.date")
                    //  q-btn(
                    //    v-if="star.state == 'planned'"
                    //    push
                    //    round
                    //    padding="xs"
                    //    class="fit"
                    //    align="around"
                    //    name="star"
                    //    text-color="yellow"
                    //    size="30px"
                    //    icon="star_border"
                    //    @click="doneStar(star)"
                    //  )
                    //  q-btn(
                    //    v-else-if="star.state == 'done'"
                    //    push
                    //    round
                    //    padding="xs"
                    //    class="fit"
                    //    align="around"
                    //    name="star"
                    //    color="light-blue-9"
                    //    text-color="yellow"
                    //    size="30px"
                    //    icon="star"
                    //    @click="undoneStar()"
                    //  )
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
      // calendar-heatmap(:values='resources')
      calendar-heatmap
      q-btn(fab color="primary" @click="newTask()" icon="add" name="new_task")
      q-dialog(v-model="new_task_show" persistent)
        new-task
</template>

<script>
  import { getTasks, deleteTask, postStar, updateStar, deleteStar } from '../api'
  import NewTask from './NewTask'
  import CalendarHeatmap from './CalendarHeatmap'

  export default {
    data () {
      return {
        selectedDate: '',
        resources: this.getTasks(),
        new_task_show: false
      }
    },
    methods: {
      getTasks() {
        getTasks()
          .then((response) => {
            this.resources = response.data.data
        })
      },
      newTask() {
        this.new_task_show = true
      },
      removeTask(task) {
        this.$q.dialog({
          title: "Удалить задание '" + task.attributes.title + "' ?",
          //message: "Вы собираетесь безвозвратно удалить задание '" + task.attributes.title + "' !",
          ok: {
            outline: true,
            color: 'negative',
            label: 'Да'
          },
          cancel: {
            flat: true,
            color: 'black',
            label: 'Нет'
          }
        }).onOk(() => {
          deleteTask(task.id)
            .then((response) => {
              this.getTasks()
            })
        }).onCancel(() => {
          // console.log('Cancel')
        }).onDismiss(() => {
          // console.log('I am triggered on both OK and Cancel')
        })
      },
      addStar(task_id, date) {
        postStar({ state: 1, task_id: task_id, due_date: date })
        .then((response) => {
          this.getTasks()
        })
      },
      // doneStar(star) {
      //   star.state = 2
      //   updateStar(star)
      //   .then((response) => {
      //     this.getTasks()
      //   })
      // },
      // undoneStar() {
      //   console.log('undone_star')
      // },
      removeStar(id) {
        deleteStar(id)
          .then((response) => {
            this.getTasks()
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
    },
    components: {
      NewTask,
      CalendarHeatmap
    }
  }
</script>