<template lang="pug">
  div
    q-card(style="width: 500px")
      q-form(enctype="multipart/form-data")
        q-card-section(class="q-gutter-y-md column")
          q-item-section
          q-input(
            filled
            ref="title"
            label="Title*"
            placeholder="Tasks title"
            v-model="task.title"
            type="text"
          )
          q-input(
            filled
            ref="title"
            label="Description"
            placeholder="Tasks description"
            v-model="task.description"
            type="textarea"
          )
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
      }
    }
  }
</script>

<style scoped></style>