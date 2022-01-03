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
            :data="taskList.table.data",
            :columns="taskList.table.columns",
            :pagination.sync="taskList.table.pagination"
            :rows-per-page-options="[10, 25, 100]"
            :filter="taskList.filter"
            binary-state-sort
            row-key="id",
            separator="cell",
            class="no-shadow",
            @request="onRequest")
            template(v-slot:body-cell-actions="props")
              q-td(key="actions")
                actions-cell(:actions="props.row.actions", :id="props.row.id" @changes="getTasks()")
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
  import LoadingMixin from 'mixins'

  export default {
    data () {
      return {
        taskList: {
          table: {
            columns: [],
            data: [],
            filter: '',
            pagination: {}
          },
          filter: ''
        }
      } 
    },
    created() {
      this.getTasks()
    },
    methods: {
      onRequest(props) {
        let { page, rowsPerPage, sortBy, descending } = props.pagination
        let filter = props.filter

        this.getTasks(page, rowsPerPage, sortBy, descending, filter)
      },
      refresh() {
        this.$refs.table.requestServerInteraction()
      },
      getTasks(page, rowsPerPage, sort, desc, filter, scopes) {
        this.$backend.tasks.index({ page, rowsPerPage, sort, desc, filter, scopes })
          .then((response) => this.taskList = response.data)
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
    },
    mixins: [
      LoadingMixin
    ]
  }
</script>

<style scoped></style>

