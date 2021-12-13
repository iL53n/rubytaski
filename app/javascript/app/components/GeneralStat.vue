<template lang="pug">
  q-card(class="col q-ma-md" style="background: linear-gradient(90deg, #847bf3 0%, #b47bf3 100%);")
    q-card-section
      div(class="row no-wrap")
        div(class="col" align="left")
          div(class="text-h1 text-white") 273
          div(class="text-subtitle1 text-grey-1") ALL STARS
          br
          div(class="text-h2 text-white") 122
          div(class="text-subtitle2 text-grey-1") THIS YEAR
          br
          div(class="text-h3 text-white") 36
          div(class="text-subtitle2 text-grey-1") THIS MONTH
          br
          div(class="text-h4 text-white") 12
          div(class="text-subtitle2 text-grey-1") THIS WEEK
          br
          div(class="text-h5 text-white") 5
          div(class="text-subtitle2 text-grey-1") TODAY
        div(class="col-auto" align="bottom")
          q-btn(color="grey-1" round flat icon="more_vert")
            q-menu(cover auto-close)
              q-list
                q-item(clickable class="text-primary")
                  q-item-section Show All Statistic
</template>

<script>
  export default {
    data () {
      return {
      }
    },
    components: {
    }
  }
</script>

<style scoped></style>