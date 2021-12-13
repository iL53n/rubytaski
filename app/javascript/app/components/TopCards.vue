<template lang="pug">
  div(class="row justify-around")
    q-card(class="col q-ma-lg")
      q-card-section
        div(class="row")
          div(class="col text-grey" align="left")
            q-icon(name="event" color="primary" size="sm")
          div(class="col text-subtitle1 text-grey" align="right") Today
        q-separator
        br
        br
        //- q-rating(
        //-   readonly
        //-   v-model="progressToday"
        //-   :max="6"
        //-   size="4em"
        //-   color="orange-3"
        //-   icon="star_border"
        //-   icon-selected="star"
        //- )
        q-slider(
          v-model="progressToday"
          :min="0"
          :max="6"
          readonly
          label
          :label-value="progressToday + ' left to complete'"
          label-always
          color="orange-4"
        )
        div(class="text-h3 text-blue-grey-14") 5/6
    q-card(class="col q-ma-lg")
      q-card-section
        div(class="row")
          div(class="col text-grey" align="left")
            q-icon(name="calendar_view_week" color="primary" size="sm")
          div(class="col text-subtitle1 text-grey" align="right") Week
        q-separator
        br
        q-linear-progress(size="60px" value=0.76 color="green-4")
          div(class="absolute-full flex flex-center")
            q-badge(color="white" text-color="green" label="76%")
        div(class="text-h3 text-blue-grey-14") 52/86
    q-card(class="col q-ma-lg")
      q-card-section
        div(class="row")
          div(class="col text-grey" align="left")
            q-icon(name="track_changes" color="primary" size="sm")
          div(class="col text-subtitle1 text-grey" align="right") Goal
        q-separator
        br
        q-knob(
          readonly
          v-model="progressGoal"
          show-value
          size="105px"
          :thickness="0.22"
          color="red-4"
          track-color="grey-3"
          class="text-blue-grey-14"
        )
          div(class="text-h3") {{progressGoal}}
          div(class="text-h6 text-grey") %
</template>

<script>
  export default {
    data () {
      return {
        progressToday: 5,
        progressGoal: 62
      }
    }
  }
</script>

<style scoped></style>

