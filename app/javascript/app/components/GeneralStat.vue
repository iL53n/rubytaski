<template lang="pug">
  div
    div(class="row no-wrap")
      div(class="col text-uppercase" align="left")
        .text-h2.text-white {{ stars_stat.all }}
        .text-caption.text-grey-1 {{ $t('stat.all_stars') }}
        br
        .text-h3.text-white {{ stars_stat.current_year }}
        .text-caption.text-grey-1 {{ $t('stat.this_year') }}
        br
        .text-h4.text-white {{ stars_stat.current_month }}
        .text-caption.text-grey-1 {{ $t('stat.this_month') }}
        br
        .text-h5.text-white {{ stars_stat.current_week }}
        .text-caption.text-grey-1 {{ $t('stat.this_week') }}
        br
        .text-h6.text-white {{ stars_stat.current_day }}
        .text-caption.text-grey-1 {{ $t('stat.today') }}
      div(class="col-auto" align="bottom")
        q-btn(color="grey-1" round flat icon="more_vert" style="bottom: 13px; left: 13px")
          q-menu(cover auto-close)
            q-list
              q-item(clickable to="/my_statistics" class="text-primary")
                q-item-section {{ $t('stat.show_all') }}
</template>

<script>
  export default {
    data () {
      return {
      }
    },
    computed: {
      stars_stat() {
        return this.$store.state.statistics.stars
      }
    },
    components: {
    }
  }
</script>

<style scoped></style>