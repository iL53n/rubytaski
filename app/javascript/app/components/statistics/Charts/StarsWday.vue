<template lang="pug">
  q-card.col.q-ma-md
    div(id="chart")
      .q-pa-sm.text-body1.text-blue-grey-8.float-left Stars by week day
      apexchart(type="radar" height="250" :options="chartOptions" :series="series")
</template>

<script>
  export default {
    data () {
      return {
        series: [{
          name: 'Series 1',
          data: [20, 112, 40, 101, 50, 80, 33],
        }],
        chartOptions: {
          colors: ['#4db6ac'],
          chart: {
            height: 250,
            type: 'radar',
          },
          dataLabels: {
            enabled: false
          },
          plotOptions: {
            radar: {
              size: 90,
              polygons: {
                strokeColors: '#e9e9e9',
                fill: {
                  colors: ['#f8f8f8', '#fff']
                }
              }
            }
          },
          markers: {
            size: 4,
            colors: ['#fff'],
            strokeColor: '#4db6ac',
            strokeWidth: 2,
          },
          tooltip: {
            y: {
              formatter: function(val) {
                return val
              }
            }
          },
          xaxis: {
            categories: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
          },
          yaxis: {
            tickAmount: 7,
            labels: {
              formatter: function(val, i) {
                if (i % 2 === 0) {
                  return val
                } else {
                  return ''
                }
              }
            }
          }
        },
      }
    },
    methods: {
    }
  }
</script>

<style scoped>

</style>

