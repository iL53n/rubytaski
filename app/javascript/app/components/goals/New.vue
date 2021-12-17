<template lang="pug">
  div(class="q-pa-md")
    q-dialog(
      :value="true"
      @hide="afterShow"
      transition-show="slide-up"
      transition-hide="slide-down"
    )
      q-card(style="width: 500px")
        q-form(enctype="multipart/form-data")
          q-card-section(class="row items-center q-pb-none text-blue-grey-14")
            .text-h5 Add Goal
            q-space
            q-btn(icon="close" flat round dense v-close-popup)
          br
          q-separator
          q-card-section(class="q-gutter-md row justify-around")
            q-input(
              class="col"
              filled
              ref="start_date"
              label="Start Date"
              v-model="goal.start_date"
              mask="date"
            )
              template(v-slot:append)
                q-icon(name="event" class="cursor-pointer")
                  q-popup-proxy(ref="qDateProxy" transition-show="scale" transition-hide="scale")
                    q-date(v-model="goal.start_date")
                      div(class="row items-center justify-end")
                        q-btn(v-close-popup label="Close" color="primary" flat)
            q-input(
              class="col"
              filled
              ref="due_date"
              label="Due Date"
              v-model="goal.due_date"
              mask="date"
            )
              template(v-slot:append)
                q-icon(name="event" class="cursor-pointer")
                  q-popup-proxy(ref="qDateProxy" transition-show="scale" transition-hide="scale")
                    q-date(v-model="goal.due_date")
                      div(class="row items-center justify-end")
                        q-btn(v-close-popup label="Close" color="primary" flat)
          q-card-section(class="q-gutter-y-md column")
            q-input(
              filled
              ref="number_of_stars"
              label="Number Of Stars"
              v-model="goal.number_of_stars"
              type="number"
            )
            q-input(
              filled
              ref="prize"
              label="Prize"
              v-model="goal.prize"
              type="text"
            )
          q-separator
          q-card-section(class="q-gutter-y-md column")
            q-card-actions(align="right" class="q-gutter-sm")
              q-btn(
                unelevated 
                color="deep-purple-1"
                text-color="primary"
                label="Cancel"
                no-caps
                v-close-popup
              )
              q-btn(
                unelevated
                color="primary"
                label="Save"
                @click="addGoal"
                no-caps
                v-close-popup
              )
</template>

<script>
  import { date } from 'quasar'

  export default {
    data: function () {
      return {
        date: '2019/02/01',
        goal: {
          start_date: '',
          due_date: ''
        },
        error: false
      }
    },
    created () {
      this.getCurrentDate()
    },
    methods: {
      addGoal() {
        this.$backend.goals.create(this.goal)
          .then((response) => {
            this.$q.notify({
              message: "Created new goal!",
              color: 'positive',
              position: 'top'
            })
          })
          .catch((error) => {
            this.error = true
            console.log(error)
            this.$q.notify({
              message: "New goal not created!",
              color: 'negative',
              position: 'top'
            })
          })
          .finally(() => {
            this.goal.title = ''
            this.loading = false
            this.$emit('add-goal')
          })
      },
      getCurrentDate() {
        let timeStamp = Date.now()
        this.goal.start_date = this.goal.due_date = date.formatDate(timeStamp, 'YYYY/MM/DD')
      },
      afterShow() {
        this.$router.go(-1)
      }
    }
  }
</script>

<style scoped></style>