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
            .text-h5 Edit Task
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
              ref="description"
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
                label="Update"
                @click="updateTask"
                no-caps
                v-close-popup
              )
</template>

<script>
  import LoadingMixin from 'mixins'
  
  export default {
    data: function () {
      return {
        task: {}
      }
    },
    created() {
      this.getTask()
    },
    methods: {
      getTask() {
        this.$backend.tasks.show(this.$route.params.id)
          .then((response) => {
            this.task = response.data.task
          })
          .catch((error) => {
            console.log(error);
            this.error = true
          })
          .finally(() => {
            this.loading = false  
          })
      },
      updateTask() {
        this.$backend.tasks.update(this.task)
          .then((response) => {
            this.$q.notify({
              message: "Updated the task!",
              color: 'positive',
              position: 'top'
            })
          })
          .catch((error) => {
            this.error = true
            console.log(error)
            this.$q.notify({
              message: "The task didn't update!",
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
    },
    mixins: [
      LoadingMixin
    ]
  }
</script>

<style scoped></style>