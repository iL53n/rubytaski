<template lang="pug">
  q-card.col.q-ma-md
    div(id="chart")
      div(style="min-height: 265px;")
        .q-pa-sm.text-body1.text-blue-grey-8.float-left Streaks
        apexchart(type="bar" height="225" :options="chartOptions" :series="series")
</template>

<script>
  export default {
    data () {
      return {
        series: [{
          name: 'Days',
          data: [16, 21, 6, 13, 8, 3, 9, 7, 8, 9, 12, 5].sort(function(a, b){return b-a})
        }],
        chartOptions: {
          colors: ['#81c784'],
          chart: {
            height: 250,
            type: 'bar'
          },
          plotOptions: {
            bar: {
              borderRadius: 1,
              horizontal: true,
            }
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
            width: 2,
          },
          xaxis: {
            categories: [
                "Застелить кровать", "Сделать зарядку", "Помочь маме", "Убрать рабочий стол", "Позаниматься англ.яз", "Сделать ДЗ", "Почитать перед сном"
            ]
          },
          yaxis: {
            labels: {
              show: false
            }
          },
          fill: {
            type: 'gradient',
            gradient: {
              shade: 'light',
              type: "vertical",
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

