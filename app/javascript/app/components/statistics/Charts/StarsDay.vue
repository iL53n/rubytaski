<template lang="pug">
  .row.justify-around
      q-card.col.q-ma-md
        div(id="chart")
          apexchart(type="area" height="350" :options="chartOptions" :series="series")

</template>

<script>
  export default {
    data () {
      return {
        series: this.data,
        chartOptions: {
          chart: {
            id: 'area-datetime',
            type: 'area',
            height: 350,
            zoom: {
              autoScaleYaxis: true
            }
          },
          title: {
            text: 'Stars'
          },
          annotations: {
          },
          dataLabels: {
            enabled: false
          },
          // markers: {
          //   size: 0,
          //   style: 'hollow',
          // },
          xaxis: {
            type: 'datetime',
            // min: new Date('01 Mar 2012').getTime(),
            tickAmount: 6,
          },
          tooltip: {
            x: {
              format: 'dd MMM yyyy'
            }
          },
          fill: {
            type: 'gradient',
            gradient: {
              shadeIntensity: 1,
              opacityFrom: 0.7,
              opacityTo: 0.9,
              stops: [0, 100]
            }
          },
        },
        // selection: 'one_year',
      }
    },
    computed: {
      data: {
        get() {
          return this.$store.state.statistics.heatmap
        },
        set(value) {
          // this.$store.commit('updateHeatmapStatistics', value)
        }
      }
    },
    created() {
      console.log(this.data)
    },
    methods: {
    }
  }
</script>

<style scoped>
</style>

