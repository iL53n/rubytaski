<template lang="pug">
  .row.justify-around
    q-card.col.q-ma-md.zoom-box
      q-card-section(horizontal)
        q-card-section.col(align="left")
          .text-h3.text-blue-grey-14 {{ stat.tasks.all }}
          .text-caption.text-blue-grey-8 Tasks
        q-card-section.flex.flex-center(align="right")
          q-btn.text-blue-4.bg-blue-1(unelevated round size="lg" icon="format_list_bulleted")
    q-card.col.q-ma-md.zoom-box
      q-card-section(horizontal)
        q-card-section.col(align="left")
          .text-h3.text-blue-grey-14 {{ stat.stars.all }}
          .text-caption.text-blue-grey-8 Completed
        q-card-section.flex.flex-center(align="right")
          q-btn.text-green-4.bg-green-1(unelevated round size="lg" icon="done_all")
    q-card.col.q-ma-md.zoom-box
      q-card-section(horizontal)
        q-card-section.col(align="left")
          .row
            .text-h3.text-blue-grey-14 {{ efficiency }}
            .text-h6.text-grey %
          .text-caption.text-blue-grey-8 Efficiency
        q-card-section.flex.flex-center(align="right")
          q-btn.text-red-4.bg-red-1(unelevated round size="lg" icon="speed")
    q-card.col.q-ma-md.zoom-box
      q-card-section(horizontal)
        q-card-section.col(align="left")
          .text-h3.text-blue-grey-14 {{ stat.general.active_days }}
          .text-caption.text-blue-grey-8 Days
        q-card-section.flex.flex-center(align="right")
          q-btn.text-teal-4.bg-teal-1(unelevated round size="lg" icon="date_range")
</template>

<script>
  export default {
    data () {
      return {
      }
    },
    computed: {
      stat: {
        get() {
          return this.$store.state.statistics
        },
        set(value) {
        }
      },
      efficiency() {
        return Math.round(this.stat.stars.all / (this.stat.tasks.all * this.stat.general.active_days) * 100)
      },
    },
    created() {
      this.getStatistics()
    },
    methods: {
      getStatistics() {
        this.$backend.statistics.index({
          scopes: 'general_stat,tasks_stat,goals_stat,stars_stat,treemap_chart'
        })
          .then((response) => {
            this.stat = response.data.stat
          })
          .catch(()   => this.error = true)
          .finally(() => this.loading = false
          )
      },
    },
    components: {
    }
  }
</script>

<style scoped>
  .zoom-box {
    transition: transform .4s;
  }

  .zoom-box:hover {
    transform: scale(1.05);
  }
</style>
