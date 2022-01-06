<template lang="pug">
  q-card(class="col-2 q-ma-lg" style="background: linear-gradient(90deg, #847bf3 0%, #b47bf3 100%);")
    q-card-section
      div(class="row no-wrap")
        div(class="col" align="left")
          .text-h1.text-white {{ stats.all }}
          .text-subtitle1.text-grey-1 ALL STARS
          br
          .text-h2.text-white {{ stats.current_year }}
          .text-subtitle2.text-grey-1 THIS YEAR
          br
          .text-h2.text-white {{ stats.current_month }}
          .text-subtitle2.text-grey-1 THIS MONTH
          br
          .text-h4.text-white {{ stats.current_week }}
          .text-subtitle2.text-grey-1 THIS WEEK
          br
          .text-h5.text-white {{ stats.current_day }}
          .text-subtitle2.text-grey-1 TODAY
        div(class="col-auto" align="bottom")
          q-btn(color="grey-1" round flat icon="more_vert")
            q-menu(cover auto-close)
              q-list
                q-item(clickable to="/statistics" class="text-primary")
                  q-item-section Show All Statistic
              //- q-item(clickable)
              //-   q-item-section Send Feedback
</template>

<script>
  export default {
    data () {
      return {
      }
    },
    computed: {
      stats() {
        return this.$store.state.statistics.stars
      }
    },
    components: {
    }
  }
</script>

<style scoped></style>