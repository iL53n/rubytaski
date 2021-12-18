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
                  @click="removeGoal(props.row)"
                  method="delete"
                  )
      router-view(@add-goal="getGoals()")
</template>

<script>
  import NewGoal from 'components/goals/New'

  export default {
    data () {
      return {
        columns: [
          { name: 'id',              required: true, label: 'ID',              align: 'left', field: row => row.id, format: val => `${val}`, sortable: true },
          { name: 'start_date',      required: true, label: 'START DATE',      align: 'left', field: row => row.start_date, format: val => `${val}`, sortable: true },
          { name: 'due_date',        required: true, label: 'DUE DATE',        align: 'left', field: row => row.due_date, format: val => `${val}`, sortable: true },
          { name: 'number_of_stars', required: true, label: 'NUMBER OF STARS', align: 'left', field: row => row.number_of_stars, format: val => `${val}`, sortable: true },
          { name: 'prize',           required: true, label: 'PRIZE',           align: 'left', field: row => row.prize, format: val => `${val}`, sortable: false },
          { name: 'state',           required: true, label: 'STATE',           align: 'left', field: row => row.state, format: val => `${val}`, sortable: true },
          { name: 'btns',                            label: 'ACTION',          align: 'left' }
        ],
        data: [],
        error: false,
        loading: true
      } 
    },
    created: function() {
      this.getGoals()
    },
    methods: {
      getGoals() {
        this.$backend.goals.index()
          .then((response) => this.data = response.data.data.map(i => i.attributes))
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
    }
  }
</script>

<style scoped></style>

