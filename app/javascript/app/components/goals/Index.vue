<template lang="pug">
    div(class="q-pa-md")
      banner
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
            class="no-shadow",
            table-header-class="text-primary"
            table-header-style="background-color: rgb(248, 247, 253)",
            wrap-cells,
            @request="onRequest")
            template(v-slot:body-cell-state="props")
              q-td(align="left")
                q-badge(
                  :color="statuses[props.row.state][1]",
                  :label="statuses[props.row.state][0]")
            template(v-slot:body-cell-actions="props")
              q-td(key="actions" align="right" style="width: 240px")
                actions-cell(
                  :actions="props.row.actions",
                  :state="props.row.state"
                  :id="props.row.id"
                  @changed="getGoals()")
      router-view(@changed="getGoals()")
</template>

<script>
  import NewGoal from 'components/goals/New'
  import ActionsCell from 'components/goals/ActionsCell'
  import Banner from 'components/goals/Banner'
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
        },
        loading: true,
        statuses: {
          'created':  ['Активная',      'green'],
          'done':     ['Достигнута',    'green-10'],
          'undone':   ['Не достигнута', 'red-10'],
          'archived': ['В архиве',      'grey']
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
          .then((response) => {
            console.log(response.data)
            this.goalList = response.data
          })
          .catch(()        => this.error = true)
          .finally(()      => this.loading = false)
      },
      newGoal() {
        this.$router.push({ name: 'newGoal' })
      },
    },
    components: {
      NewGoal,
      ActionsCell,
      Banner
    },
    mixins: [
      LoadingMixin
    ],
    subscriptions: {
      GoalsChannel: {
        received(data) {
          this.getGoals()
        }
      }
    }
  }
</script>

<style scoped></style>

