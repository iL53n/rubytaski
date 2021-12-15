<template lang="pug">
  div(class="q-pa-md")
    q-dialog(
      :value="true"
      @hide="afterShow"
      :maximized="maximizedToggle"
      transition-show="slide-up"
      transition-hide="slide-down"
    )
      q-card(style="width: 500px")
        q-form(enctype="multipart/form-data")
          q-card-section(class="row items-center q-pb-none text-blue-grey-14")
            .text-h5 Add Task
            q-space
            q-btn(icon="close" flat round dense v-close-popup)
          br
          q-separator
          q-card-section(class="q-gutter-y-md column")
            q-input(
              filled
              ref="title"
              label="Title*"
              placeholder="Task title"
              v-model="task.title"
              type="text"
            )
            q-input(
              filled
              ref="title"
              label="Description"
              placeholder="Task description"
              v-model="task.description"
              type="textarea"
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
                @click="addTask"
                no-caps
                v-close-popup
              )
</template>

<script>
  export default {
    data: function () {
      return {
        task: {},
        error: Boolean
      }
    },
    methods: {
      addTask() {
        this.$backend.tasks.create(this.task)
          .then((response) => {
            this.$q.notify({
              message: "Created new task!",
              color: 'positive',
              position: 'top'
            })
          })
          .catch((error) => {
            this.error = true
            console.log(error)
            this.$q.notify({
              message: "New task not created!",
              color: 'negative',
              position: 'top'
            })
          })
          .finally(() => {
            this.task.title = ''
            this.loading = false
            this.$emit('add-task', this.task.title)
          })
      },
      afterShow() {
        this.$router.go(-1)
      }
    }
  }
</script>

<style scoped></style>