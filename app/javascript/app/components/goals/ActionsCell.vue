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
    props: ['actions', 'id'],
    methods: {
      apply(action) {
        if (typeof this[action] === 'function') this[action]()
      },
      edit() {
        this.$router.push({ name: 'editTask' })
      },
      archive() {
        this.$router.push({ name: 'archiveTask' })
      },
      destroy() {
        this.$q.dialog({
          title: "Delete the goal?",
          message: "You are about to permanently delete the goal with all progress? Are you sure?",
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
          this.$backend.goals.destroy(this.id)
          .then((response) => {
            this.$q.notify({
              message: "The goal deleted!",
              color: 'negative',
              position: 'top'
            })
          })
          .catch((error) => {
            this.error = true
            console.log(error)
            this.$q.notify({
              message: "The goal didn't delete!",
              color: 'negative',
              position: 'top'
            })
          })
          .finally(() => this.$emit('changed'))
        }).onCancel(() => {
          // console.log('Cancel')
        }).onDismiss(() => {
          // console.log('I am triggered on both OK and Cancel')
        })
      },
    }
  }
</script>
