<template lang="pug">
  div(class="q-pa-md")
    q-dialog(
      :value="true"
      @hide="afterShow"
      transition-show="slide-up"
      transition-hide="slide-down"
    )
      q-card(style="width: 500px")
        q-form(enctype="multipart/form-data")
          q-card-section(class="row items-center q-pb-none text-blue-grey-14")
            .text-h5 Done Goal
            q-space
            q-btn(icon="close" flat round dense v-close-popup)
          br
          q-separator
          q-card-section(class="q-gutter-md row justify-around")
            q-slider(
              v-model="donePercent"
              :min="0"
              :max="100"
              readonly
              label
              :label-value="donePercent + '%'"
              label-always
              color="orange-4"
            )
            .text-subtitle1 Вы хотите закрыть цель. У вас есть возможность отметить цель как достигнутую или нет.
          q-separator
          q-card-section(class="q-gutter-y-md column")
            q-card-actions(align="right" class="q-gutter-sm")
              q-btn(
                flat
                unelevated 
                text-color="primary"
                label="Отмена"
                no-caps
                v-close-popup
              )
              q-btn-group
                q-btn(
                  unelevated
                  color="green-5"
                  label="Достигнута"
                  @click="done()"
                  no-caps
                  v-close-popup
                )
                q-btn(
                  unelevated
                  color="red-5"
                  label="Не достигнута"
                  @click="undone()"
                  no-caps
                  v-close-popup
                )
</template>

<script>
  export default {
    data: function () {
      return {
        goal: {},
        donePercent: 56
      }
    },
    created() {
      this.getGoal()
    },
    methods: {
      getGoal() {
        this.$backend.goals.show(this.$route.params.id)
          .then((response) => {
            this.goal = response.data.goal
          })
          .catch((error) => {
            console.log(error);
            this.error = true
          })
          .finally(() => {
            // this.loading = false  
          })
      },
      done() {
        this.$backend.goals.set_state({ id: this.goal.id, state: 'complete' })
          .then((response) => {
            this.$q.notify({
              message: "Done the goal!",
              color: 'positive',
              position: 'top'
            })
          })
          .catch((error) => {
            this.error = true
            console.log(error)
            this.$q.notify({
              message: "The goal didn't update!",
              color: 'negative',
              position: 'top'
            })
          })
          .finally(() => {
            // this.loading = false
            this.$emit('changed')
          })
      },
      undone() {
        this.$backend.goals.set_state({ id: this.goal.id, state: 'uncomplete' })
          .then((response) => {
            this.$q.notify({
              message: "Undone the goal!",
              color: 'positive',
              position: 'top'
            })
          })
          .catch((error) => {
            this.error = true
            console.log(error)
            this.$q.notify({
              message: "The goal didn't update!",
              color: 'negative',
              position: 'top'
            })
          })
          .finally(() => {
            // this.loading = false
            this.$emit('changed')
          })
      },
      afterShow() {
        this.$router.go(-1)
      }
    }
  }
</script>

<style scoped></style>