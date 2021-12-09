<template lang="pug">
  div
    q-page-container(align="middle")
      div(class="q-pa-md row justify-around q-gutter-sm")
        q-card(class="col")
          q-card-section
            div(class="text-h5 text-grey" align="right") Today
            q-separator
            br
            q-rating(
              readonly
              v-model="progressToday"
              size="5em"
              color="orange-3"
              icon="star_border"
              icon-selected="star"
            )
            div(class="text-h2 text-blue-grey-14") 3/5
        q-card(class="col")
          q-card-section
            div(class="text-h5 text-grey" align="right") Week
            q-separator
            br
            q-linear-progress(size="70px" value=0.76 color="green-4")
              div(class="absolute-full flex flex-center")
                q-badge(color="white" text-color="green" label="76%")
            div(class="text-h2 text-blue-grey-14") 52/86
        q-card(class="col")
          q-card-section
            div(class="text-h5 text-grey" align="right") Goal
            q-separator
            br
            q-knob(
              readonly
              v-model="progressGoal"
              show-value
              size="130px"
              :thickness="0.22"
              color="red-4"
              track-color="grey-3"
              class="text-blue-grey-14"
            ) {{progressGoal}} %
</template>

<script>
  export default {
    data () {
      return {
        progressToday: 3,
        progressGoal: 62
      }
    }
  }
</script>
<style scoped></style>

