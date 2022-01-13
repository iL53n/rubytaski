<template lang="pug">
    div(class="q-pa-md")
      div(align="left")
      q-card(class="col-2 q-ma-lg")
        q-card-section(class="row")
          div(class="col text-h3 text-blue-grey-14" align="left") {{ $t('goals.title') }}
          div(class="col text-subtitle1 text-grey" align="right")
            br
            q-btn(unelevated rounded no-caps color="deep-purple-1" text-color="primary" @click="newGoal()" icon="add" name="new_goal" label="Add Goal")
        q-card-section
          q-table(
            ref="table"
            :loading="loading"
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
                actions-cell(
                  :actions="props.row.actions",
                  :id="props.row.id"
                  @changed="getGoals()")
      router-view(@add-goal="getGoals()")
</template>

<script>
  import NewGoal from 'components/goals/New'
  import ActionsCell from 'components/goals/ActionsCell'
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
      // TODO
      // this.onRequest({ pagination: this.goalList.pagination })
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
    },
    components: {
      NewGoal,
      ActionsCell
    },
    mixins: [
      LoadingMixin
    ]
  }
</script>

<style scoped></style>

