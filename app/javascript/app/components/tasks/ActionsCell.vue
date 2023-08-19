<template lang="pug">
  div
    q-btn(
      v-for="action in actions"
      v-if="state === 'created' && ['all', 'active'].includes(action.kind)"
      :key="action.name"
      :name="action.name"
      flat
      bordered
      color="white"
      :text-color="action.color"
      size="11px"
      :icon="action.icon"
      @click="apply(action.name)")
    q-btn(
      v-for="action in actions"
      v-if="state !== 'created' && ['all', 'unactive'].includes(action.kind)"
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
    props: ['actions', 'title', 'state', 'id'],
    methods: {
      apply(action) {
        if (typeof this[action] === 'function') this[action]()
      },
      reminder() {
        this.$router.push({ name: 'indexTaskReminders', params: { id: this.id } })
      },
      edit() {
        this.$router.push({ name: 'editTask', params: { id: this.id } })
      },
      archive() {
        this.$q.dialog({
          title: "Archive the task?",
          message: "You are about to archive the task? Are you sure?",
          ok: { outline: true, color: 'negative', label: 'Yes' },
          cancel: { flat: true, color: 'black', label: 'No' }
        }).onOk(() => {
          this.$backend.tasks.set_state({ id: this.id, state: 'archive' })
          .then((response) => {
            this.$q.notify({ message: "The task archived!", color: 'positive', position: 'top' })
          })
          .catch((error) => {
            this.error = true
            console.log(error)
            this.$q.notify({ message: "The task didn't archive!", color: 'negative', position: 'top' })
          })
          .finally(() => this.$emit('changed'))
        }).onCancel(() => {}).onDismiss(() => {})
      },
      unarchive() {
        this.$q.dialog({
          title: "Unarchive the task?",
          message: "You are about to unarchive the taks? Are you sure?",
          ok: { outline: true, color: 'positive', label: 'Yes' },
          cancel: { flat: true, color: 'black', label: 'No' }
        }).onOk(() => {
          this.$backend.tasks.set_state({ id: this.id, state: 'unarchive' })
          .then((response) => {
            this.$q.notify({ message: "The task unarchived!", color: 'positive', position: 'top' })
          })
          .catch((error) => {
            this.error = true
            console.log(error)
            this.$q.notify({ message: "The task didn't unarchive!", color: 'negative', position: 'top' })
          })
          .finally(() => this.$emit('changed'))
        }).onCancel(() => {}).onDismiss(() => {})
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
          .finally(() => this.$emit('changed'))
        }).onCancel(() => {}).onDismiss(() => {})
      },
    }
  }
</script>
