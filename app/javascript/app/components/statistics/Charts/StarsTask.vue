<template lang="pug">
  .row.justify-around
      q-card.col.q-ma-md
        div(id="chart")
          apexchart(type="bar" height="350" :options="chartOptions" :series="series")

</template>

<script>
  export default {
    data () {
      return {
        series: [{
          name: 'Stars',
          data: [44, 55, 41, 67, 22, 43, 21, 33, 45, 31, 87, 65]
        }],
        chartOptions: {
          annotations: {
            // points: [{
            //   x: 'Bananas',
            //   seriesIndex: 0,
            //   label: {
            //     borderColor: '#775DD0',
            //     offsetY: 0,
            //     style: {
            //       color: '#fff',
            //       background: '#775DD0',
            //     },
            //     text: 'Bananas are good',
            //   }
            // }]
          },
          chart: {
            height: 350,
            type: 'bar',
          },
          plotOptions: {
            bar: {
              borderRadius: 10,
              columnWidth: '50%',
            }
          },
          title: {
            text: 'Stars by task'
          },
          dataLabels: {
            enabled: false
          },
          stroke: {
            width: 2
          },

          grid: {
            row: {
              colors: ['#fff', '#f2f2f2']
            }
          },
          xaxis: {
            labels: {
              rotate: -45
            },
            categories: [
              'Task1', 'Task2', 'Task3', 'Task4', 'Task5', 'Task6',
              'Task7', 'Task8', 'Task9', 'Task10', 'Task11', 'Task12',
            ],
            tickPlacement: 'on'
          },
          yaxis: {
            title: {
              text: 'Stars',
            },
          },
          fill: {
            type: 'gradient',
            gradient: {
              shade: 'light',
              type: "horizontal",
              shadeIntensity: 0.25,
              gradientToColors: undefined,
              inverseColors: true,
              opacityFrom: 0.85,
              opacityTo: 0.85,
              stops: [50, 0, 100]
            },
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

