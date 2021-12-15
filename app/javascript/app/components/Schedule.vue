<template lang="pug">
  div
    //- q-toolbar(class="bg-green-3")
      //- q-toolbar-title(align="middle") #моянеделя
    div(class="row justify-around")
      q-card(class="col-2 q-ma-lg" style="background: linear-gradient(90deg, #847bf3 0%, #b47bf3 100%);")
        q-card-section
          div(class="row no-wrap")
            div(class="col" align="left")
              div(class="text-h1 text-white") 273
              div(class="text-subtitle1 text-grey-1") ALL STARS
              br
              div(class="text-h2 text-white") 122
              div(class="text-subtitle2 text-grey-1") THIS YEAR
              br
              div(class="text-h3 text-white") 36
              div(class="text-subtitle2 text-grey-1") THIS MONTH
              br
              div(class="text-h4 text-white") 12
              div(class="text-subtitle2 text-grey-1") THIS WEEK
              br
              div(class="text-h5 text-white") 5
              div(class="text-subtitle2 text-grey-1") TODAY
            div(class="col-auto" align="bottom")
              q-btn(color="grey-1" round flat icon="more_vert")
                q-menu(cover auto-close)
                  q-list
                    q-item(clickable class="text-primary")
                      q-item-section Show All Statistic
                  //- q-item(clickable)
                  //-   q-item-section Send Feedback
      q-card(class="col-grow q-ma-lg")
        q-card-section
          // weekdays=[0,1,2,3,4,5,6,7]
          q-calendar(
            ref="calendar"
            v-model="selectedDate"
            view="week-scheduler"
            :resources="resources"
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
                  div(class="ellipsis") {{ resource.attributes.title }}
                  q-btn(
                    name="delete"
                    flat
                    round
                    color="white"
                    text-color="negative"
                    size="10px"
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
    q-btn(unelevated rounded no-caps color="deep-purple-1" text-color="primary" @click="newTask()" icon="add" name="new_task" label="Add Task")
    router-view
</template>

<script>
  import NewTask from 'components/tasks/New'

  export default {
    data () {
      return {
        selectedDate: '',
        resources: this.getTasks(),
        error: Boolean
      }
    },
    created: function() {
      this.getTasks
    },
    methods: {
      getTasks() {
        this.$backend.tasks.index()
          .then((response) => this.resources = response.data.data)
          .catch(()        => this.error = true)
          .finally(()      => this.loading = false)
      },
      newTask() {
        this.$router.push({ name: 'dashboardNewTask' })
      },
      addTask(title) {
        this.$backend.tasks.create()
          .then((response) => {
            this.getTasks(),
            this.new_task_show = false
          })
          .catch(()   => this.error = true)
          .finally(() => this.loading = false)
      },
      showTask(task_id) {
        this.$router.push({ name: 'dashboardShowTask', params: { id: task_id } })
      },
      removeTask(task) {
        this.$q.dialog({
          title: "Delete the task '" + task.attributes.title + "' ?",
          message: "You are about to permanently delete the task '" + task.attributes.title + "' with all earned stars! Are you sure?",
          ok: {
            outline: true,
            color: 'negative',
            label: 'Yes'
          },
          cancel: {
            flat: true,
            color: 'black',
            label: 'No'
          }
        }).onOk(() => {
          this.$backend.tasks.destroy(task.id)
          .then((response) => {
            this.getTasks()
            this.$q.notify({
              message: "The task deleted!",
              color: 'negative',
              position: 'top'
            })
          })
          .catch((error) => {
            this.error = true
            console.log(error)
            this.$q.notify({
              message: "The task didn't delete!",
              color: 'negative',
              position: 'top'
            })
          })
          .finally(() => this.loading = false)
        }).onCancel(() => {
          // console.log('Cancel')
        }).onDismiss(() => {
          // console.log('I am triggered on both OK and Cancel')
        })
      },
      addStar(task_id, date) {
        let params = { state: 1, task_id: task_id, due_date: date }

        this.$backend.stars.create(params)
          .then((response) => {
            this.getTasks()
          })
          .catch(()   => this.error = true)
          .finally(() => this.loading = false)
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
        this.$backend.stars.destroy(id)
          .then((response) => {
            this.getTasks()
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
    components: {
      NewTask
    }
  }
</script>