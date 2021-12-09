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
              v-close-popup
            )
            q-btn(
              unelevated
              color="primary"
              label="Save"
              @click="addTask"
              v-close-popup
            )
</template>

<script>
  export default {
    data: function () {
      return {
        task: {}
      }
    },
    methods: {
      addTask() {
        this.$backend.tasks.create(this.task)
          .then((response) => {
            this.$emit('add-task', this.task.title)
            this.task.title = ''
          })
          .catch(()   => this.error = true)
          .finally(() => this.loading = false)
      }
    }
  }
</script>

<style scoped></style>