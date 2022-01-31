<template lang="pug">
  div(class="q-pa-md")
    q-dialog(
      :value="true"
      @hide="afterShow"
      :maximized="maximizedToggle"
      transition-show="slide-up"
      transition-hide="slide-down"
    )
      q-card(class="text-grey-10" style="width: 800px; max-width: 80vw;")
        .text-h3 {{ task.title }}
        .text-h5 {{ task }}
</template>

<script>
  export default {
    data: function () {
      return {
        task: Object,
        error: Boolean,
        maximizedToggle: false
      }
    },
    computed: {
      id () {
        return this.$route.params.id
      }
    },
    created() {
      this.getTask()
    },
    methods: {
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

<style scoped></style>