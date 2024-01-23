<template lang="pug">
q-dialog(
  :value="true"
  @hide="afterShow"
  :maximized="maximizedToggle"
  transition-show="slide-up"
  transition-hide="slide-down"
)
  q-card(class="text-grey-10" flat bordered style="width: 100%; max-width: 600px")
    q-card-section(horizontal)
      q-card-section(class="col")
        div(class="text-h5 q-mt-sm q-mb-xs") {{ task.title }}
        div {{ task.description }}
        div(class="absolute")
          q-btn(color="grey-4" round flat icon="info")
            q-menu(auto-close self="top end")
              q-list
                q-item
                  q-item-section
                    q-item-label {{ task.created_at }}
                    q-item-label(caption) Created
                q-item
                  q-item-section
                    q-item-label {{ task.updated_at }}
                    q-item-label(caption) Updated
        br
        q-separator
        br
        q-btn(
          @click="showReminders"
          color="blue-5"
          outline
          no-caps
          icon="alarm"
         :label="reminder_btn_label"
        )
        q-btn(
          @click="deleteReminder"
          flat
          round
          size="sm"
          color="blue-5"
          icon="close"
        )
      q-separator(vertical)
      q-card-actions(vertical align="left" dense class="justify-around q-px-md")
        q-item
          q-item-section(avatar)
            q-icon(color="amber-4" name="star" size="md")
          q-item-section
            q-item-label {{ task.stars_count }}
            q-item-label(caption) All stars
        q-item
          q-item-section(avatar)
            q-icon(color="teal-4" name="insights" size="md")
          q-item-section
            q-item-label {{ task.current_streak }}
            q-item-label(caption) Current streak
        q-item
          q-item-section(avatar)
            q-icon(color="deep-purple-4" name="linear_scale" size="md")
          q-item-section
            q-item-label {{ task.longest_streak }}
            q-item-label(caption) Longest streak
</template>

<script>
  export default {
    data: function () {
      return {
        task: {
          type: Object,
          required: true
        },
        error: Boolean,
        maximizedToggle: false
      }
    },
    computed: {
      id () {
        return this.$route.params.id
      },
      reminder_btn_label () {
        if (this.task.has_reminder) {
          return `${this.toLocal(this.task.reminder_info.time_utc)}${this.task.reminder_info.text_days}`
        } else {
          return "No reminders"
        }
      }
    },
    created() {
      this.getTask()
    },
    methods: {
      toLocal(utcTime) {
        const utcDate = new Date(`1963-01-01T${utcTime}`);
        const localTime = new Date(utcDate.getTime() - utcDate.getTimezoneOffset() * 60000);
        const options = { hour: "2-digit", minute: "2-digit" };
        const localTimeString = localTime.toLocaleTimeString(undefined, options);
        return localTimeString;
      },
      showReminders() {
        this.$router.push({ name: 'dashboardTaskReminders', params: { id: this.id } })
      },
      deleteReminder() {
        this.$backend.tasks.delete_reminder(this.id)
          .then((response) => {
            this.task = response.data.task
          })
          .catch(()   => this.error = true)
          .finally(() => this.loading = false)
      },
      getTask() {
        this.$backend.tasks.show(this.id)
          // .then(({ data }) => this.task = data)
          .then((response) => {
            this.task = response.data.task
          })
          .catch(()   => this.error = true)
          .finally(() => this.loading = false)
      },
      afterShow() {
        this.$router.go(-1)
      }
    }
  }
</script>

<style scoped>
.absolute {
  position: absolute;
  top: 0;
  right: 0;
}
</style>
