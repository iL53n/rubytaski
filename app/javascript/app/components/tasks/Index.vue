<template lang="pug">
    div(class="q-pa-md")
      div(align="left")
      q-card(class="col-2 q-ma-lg")
        q-card-section(class="row")
          div(class="col text-h2" align="left") Tasks
          div(class="col text-subtitle1 text-grey" align="right")
            br
            q-btn(unelevated rounded no-caps color="deep-purple-1" text-color="primary" @click="newTask()" icon="add" name="new_task" label="Add Task")
        q-card-section
          q-table(
            :data="data",
            :columns="columns",
            row-key="id",
            separator="cell"
            class="no-shadow")
            template(v-slot:body-cell-btns="props")
              q-td
                q-btn(
                  name="edit"
                  flat
                  bordered
                  color="white"
                  text-color="green-5"
                  size="11px"
                  icon="edit"
                  @click=""
                )
                q-btn(
                  name="archive"
                  flat
                  bordered
                  color="white"
                  text-color="orange-5"
                  size="11px"
                  icon="archive"
                  @click=""
                )
                q-btn(
                  name="delete"
                  flat
                  bordered
                  color="white"
                  text-color="red-5"
                  size="11px"
                  icon="delete"
                  @click="removeTask(props.row)"
                  method="delete"
                )
      router-view(@add-task="getTasks()")
</template>

<script>
  import NewTask from 'components/tasks/New'

  export default {
    data () {
      return {
        columns: [
          { name: 'id',          required: true,  label: 'ID',          align: 'left', field: row => row.id, format: val => `${val}`, sortable: true },
          { name: 'title',       required: true,  label: 'TITLE',       align: 'left', field: row => row.title, format: val => `${val}`, sortable: true },
          { name: 'description', required: false, label: 'DESCRIPTION', align: 'left', field: row => row.description, format: val => `${val}`, sortable: false },
          { name: 'btns',                         label: 'ACTION',      align: 'left' }
        ],
        data: [],
        error: false,
        loading: true
      } 
    },
    created: function() {
      this.getTasks()
    },
    methods: {
      getTasks() {
        this.$backend.tasks.index()
          .then((response) => this.data = response.data.data.map(i => i.attributes))
          .catch(()        => this.error = true)
          .finally(()      => this.loading = false)
      },
      newTask() {
        this.$router.push({ name: 'newTask' })
      },
      removeTask(task) {
        this.$q.dialog({
          title: "Delete the task '" + task.title + "' ?",
          message: "You are about to permanently delete the task '" + task.title + "' with all earned stars! Are you sure?",
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
          this.$backend.tasks.destroy(task.id)
          .then((response) => {
            this.getTasks()
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
          .finally(() => this.loading = false)
        }).onCancel(() => {
          // console.log('Cancel')
        }).onDismiss(() => {
          // console.log('I am triggered on both OK and Cancel')
        })
      },
    },
    components: {
      NewTask
    }
  }
</script>

<style scoped></style>

