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
          data: [16, 1, 5, 21, 6, 13, 8, 3, 9, 17, 8]
        }],
        chartOptions: {
          chart: {
            type: 'bar',
            height: 350
          },
          plotOptions: {
            bar: {
              borderRadius: 4,
              horizontal: true,
            }
          },
          title: {
            text: 'Streak of stars'
          },
          dataLabels: {
            enabled: true,
            offsetX: -6,
            style: {
              fontSize: '12px',
              colors: ['#fff']
            }
          },
          stroke: {
            show: true,
            width: 1,
            colors: ['#fff']
          },
          tooltip: {
            shared: true,
            intersect: false
          },

          xaxis: {
            categories: [
              'Task 1', 'Task 2', 'Task 3', 'Task 4', 'Task 5', 'Task 6',
              'Task 7', 'Task 8', 'Task 9', 'Task 10', 'Task 11', 'Task 12',
            ],
          }
        },
        selection: 'one_year',
      }
    },
    methods: {
    }
  }
</script>

<style scoped>

</style>

