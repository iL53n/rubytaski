<template lang="pug">
    div(class="q-pa-md")
      div(align="left")
      q-card(class="col-2 q-ma-lg")
        q-card-section(class="row")
          div(class="col text-h2" align="left") Goals
          div(class="col text-subtitle1 text-grey" align="right")
            br
            q-btn(unelevated rounded no-caps color="deep-purple-1" text-color="primary" @click="newGoal()" icon="add" name="new_goal" label="Add Goal")
        q-card-section
          q-table(
            :data="goalList.table.data",
            :columns="goalList.table.columns",
            :pagination.sync="goalList.table.pagination"
            :rows-per-page-options="[10, 25, 100]"
            :filter="goalList.filter"
            binary-state-sort
            row-key="id",
            separator="cell",
            class="no-shadow",
            @request="onRequest")
            template(v-slot:body-cell-actions="props")
              q-td(key="actions")
                actions-cell(:actions="props.row.actions", :id="props.row.id" @changes="getGoals()")
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
                  @click="removeGoal(props.row)"
                  method="delete"
                  )
      router-view(@add-goal="getGoals()")
</template>

<script>
  import NewGoal from 'components/goals/New'
  import LoadingMixin from 'mixins'

  export default {
    data () {
      return {
        goalList: {
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
    created: function() {
      this.getGoals()
    },
    methods: {
      onRequest(props) {
        let { page, rowsPerPage, sortBy, descending } = props.pagination
        let filter = props.filter

        this.getGoals(page, rowsPerPage, sortBy, descending, filter)
      },
      refresh() {
        this.$refs.table.requestServerInteraction()
      },
      getGoals(page, rowsPerPage, sort, desc, filter, scopes) {
        this.$backend.goals.index({ page, rowsPerPage, sort, desc, filter, scopes })
          .then((response) => this.goalList = response.data)
          .catch(()        => this.error = true)
          .finally(()      => this.loading = false)
      },
      newGoal() {
        this.$router.push({ name: 'newGoal' })
      },
      removeGoal(goal) {
        this.$q.dialog({
          title: "Delete the goal '" + goal.title + "' ?",
          message: "You are about to permanently delete the goal '" + goal.title + "' with all earned stars! Are you sure?",
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
          this.$backend.goals.destroy(goal.id)
          .then((response) => {
            this.getGoals()
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
          .finally(() => this.loading = false)
        }).onCancel(() => {
          // console.log('Cancel')
        }).onDismiss(() => {
          // console.log('I am triggered on both OK and Cancel')
        })
      },
    },
    components: {
      NewGoal
    },
    mixins: [
      LoadingMixin
    ]
  }
</script>

<style scoped></style>

