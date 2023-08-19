<template lang="pug">
.q-pa-md
  q-dialog(
    :value="true"
    @hide="afterShow"
    transition-show="slide-up"
    transition-hide="slide-down"
  )
    q-card
      q-form(enctype="multipart/form-data")
        q-card-section.row.items-center.q-pb-none.text-blue-grey-14
          .col
            .text-h5 Add Reminders
            .text-subtitle2 set everyweek reminders
          .col-auto
            q-btn(icon="close" flat round dense v-close-popup)
        q-separator
        q-card-section(align="center")
          q-input(filled v-model="time" mask="time" :rules="['time']")
            template(v-slot:append)
              q-icon.cursor-pointer(name="access_time")
                q-popup-proxy(cover transition-show="scale" transition-hide="scale")
                  q-time(v-model="time" format24h color="primary")
                    .row.items-center.justify-end
                      q-btn(v-close-popup label="Close" color="primary" flat)
          span(v-for="day in days" :key="day.value")
            q-checkbox(
              v-model="selection",
              :val="day.value",
              :label="day.label",
              size="xs",
              color="primary"
          )
        q-separator
        q-card-section.q-gutter-y-md.column
          q-card-actions.q-gutter-sm(align="right")
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
              @click="addReminders"
              no-caps
              v-close-popup
            )
</template>

<script>
  import { date } from 'quasar'

  export default {
    data: function () {
      return {
        recurrence: 'weekly',
        days: [
          {label: 'Mon', value: 1},
          {label: 'Tue', value: 2},
          {label: 'Wed', value: 3},
          {label: 'Thu', value: 4},
          {label: 'Fri', value: 5},
          {label: 'Sat', value: 6},
          {label: 'Sun', value: 0},
      ],
        selection: [],
        time: '09:00',
        error: false,
      }
    },
    computed: {
      id () {
        return this.$route.params.id
      }
    },
    created () {

    },
    methods: {
      toUTC(time) {
        const localDate = new Date(`1963-01-01T${time}:00`);
        const utcTime = localDate.toISOString().substr(11, 5);
        return utcTime
      },
      addReminders() {
        const utcTime = this.toUTC(this.time)

        this.$backend.tasks.create_reminders(
          {
            task_id: this.id,
            recurrence: this.recurrence,
            days: this.selection,
            remind_at: utcTime
          }
        )
          .then((_response) => {
            this.$q.notify({
              message: "Created new reminders!",
              color: 'positive',
              position: 'top'
            })
          })
          .catch((error) => {
            this.error = true
            console.log(error)
            this.$q.notify({
              message: "New reminders didn't create!",
              color: 'negative',
              position: 'top'
            })
          })
          .finally(() => {
            this.loading = false
            this.$emit('refresh')
          })
      },
      afterShow() {
        this.$router.go(-1)
      }
    }
  }
</script>

<style scoped></style>
