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
            ref="table"
            :loading="loading"
            :data="taskList.table.data"
            :columns="taskList.table.columns"
            :pagination.sync="taskList.table.pagination"
            :rows-per-page-options="[10, 25, 100]"
            :filter="taskList.filter"
            binary-state-sort
            row-key="id"
            separator="cell"
            class="no-shadow"
            @request="onRequest")
            template(v-slot:body-cell-actions="props")
              q-td(key="actions")
                actions-cell(
                  :actions="props.row.actions",
                  :title="props.row.title",
                  :id="props.row.id"
                  @changed="getTasks()")
      router-view(@add-task="getTasks()")
</template>

<script>
  import NewTask from 'components/tasks/New'
  import ActionsCell from 'components/tasks/ActionsCell'
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
      // TODO
      // this.onRequest({ pagination: this.taskList.pagination })
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
    },
    components: {
      NewTask,
      ActionsCell
    },
    mixins: [
      LoadingMixin
    ]
  }
</script>

<style scoped></style>

