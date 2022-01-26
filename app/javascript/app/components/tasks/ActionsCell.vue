<template lang="pug">
  div
    q-btn(
      v-for="action in actions"
      :key="action.name"
      :name="action.name"
      flat
      bordered
      color="white"
      :text-color="action.color"
      size="11px"
      :icon="action.icon"
      @click="apply(action.name)")
</template>

<script>
  export default {
    props: ['actions', 'title', 'id'],
    methods: {
      apply(action) {
        if (typeof this[action] === 'function') this[action]()
      },
      edit() {
        this.$router.push({ name: 'editTask', params: { id: this.id } })
      },
      archive() {
        this.$router.push({ name: 'archiveTask', params: { id: this.id } })
      },
      destroy() {
        this.$q.dialog({
          title: "Delete the task '" + this.title + "' ?",
          message: "You are about to permanently delete the task '" + this.title + "' with all earned stars! Are you sure?",
          ok: { outline: true, color: 'negative', label: 'Yes' },
          cancel: { flat: true, color: 'black', label: 'No' }
        }).onOk(() => {
          this.$backend.tasks.destroy(this.id)
          .then((response) => {
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
          .finally(() => this.$emit('refresh'))
        }).onCancel(() => {
          // console.log('Cancel')
        }).onDismiss(() => {
          // console.log('I am triggered on both OK and Cancel')
        })
      },
    }
  }
</script>
