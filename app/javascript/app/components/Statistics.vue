<template lang="pug">
  div
    .text-h3.text-blue-grey-14 {{ $t('stat.title') }} DEMO
    .row.justify-around
      q-card.col.q-ma-md
        q-card-section(horizontal)
          q-card-section.col(align="left")
            .text-h3.text-blue-grey-14 {{ stat.tasks.all }}
            .text-caption.text-blue-grey-8 Tasks
          q-card-section.flex.flex-center(align="right")
            q-btn.text-blue-4.bg-blue-1(unelevated round size="lg" icon="format_list_bulleted")
      q-card.col.q-ma-md
        q-card-section(horizontal)
          q-card-section.col(align="left")
            .text-h3.text-blue-grey-14 {{ stat.stars.all }}
            .text-caption.text-blue-grey-8 Completed
          q-card-section.flex.flex-center(align="right")
            q-btn.text-green-4.bg-green-1(unelevated round size="lg" icon="done_all")
      q-card.col.q-ma-md
        q-card-section(horizontal)
          q-card-section.col(align="left")
            .row
              .text-h3.text-blue-grey-14 {{ efficiency }}
              .text-h6.text-grey %
            .text-caption.text-blue-grey-8 Efficiency
          q-card-section.flex.flex-center(align="right")
            q-btn.text-red-4.bg-red-1(unelevated round size="lg" icon="speed")  
      q-card.col.q-ma-md
        q-card-section(horizontal)
          q-card-section.col(align="left")
            .text-h3.text-blue-grey-14 {{ stat.general.active_days }}
            .text-caption.text-blue-grey-8 Days
          q-card-section.flex.flex-center(align="right")
            q-btn.text-teal-4.bg-teal-1(unelevated round size="lg" icon="date_range")

    .row.justify-around
      q-card.col.q-ma-md
        q-card-section.flex.flex-center
          apexchart(:options="treemap.options" :series="stat.treemap")
      q-card.col.q-ma-md
        | DEMO
        apexchart(height="200" width="500" type="line" :options="options" :series="series")
      q-card.col.q-ma-md
        | DEMO
        apexchart(height="200" width="500" type="area" :options="options" :series="series")
    .row.justify-around
      q-card.col.q-ma-md
        | DEMO
        apexchart(height="200" width="500" type="heatmap" :options="options" :series="series")
      q-card.col.q-ma-md
        | DEMO
        apexchart(height="200" width="500" type="scatter" :options="options" :series="series")
    .row.justify-around
      q-card.col.q-ma-md
        | DEMO
        apexchart(height="200" width="500" type="radar" :options="options" :series="series")
      q-card.col.q-ma-md
        | DEMO
        apexchart(height="200" width="500" type="area" :options="options" :series="series")
</template>

<script>

  export default {
    data () {
      return {
        treemap: {
          options: {
            legend: {
              show: false
            },
            chart: {
              // height: 200,
              // width: 500,
              type: 'treemap'
            },
            title: {
              text: 'Tasks Treemap'
            }
          },
        },
        options: {
          chart: {
            id: 'vuechart-example'
          },
          xaxis: {
            categories: [1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998]
          }
        },
        series: [{
          name: 'demo_series',
          data: [30, 40, 15, 60, 80, 10, 90, 70]
        }]
      }
    },
    computed: {
      stat: {
        get() {
          return this.$store.state.statistics
        },
        set(value) {
          this.$store.commit('updateAllStatistics', value)
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
        this.$backend.statistics.index({ scopes: 'general_stat,tasks_stat,goals_stat,stars_stat,treemap_chart' })
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

<style scoped></style>

