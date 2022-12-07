<template lang="pug">
  q-card.col.q-ma-md
    div(id="chart")
      div(style="min-height: 265px;")
        .q-pa-sm.text-body1.text-blue-grey-8.float-left Stars by task
        apexchart(type="bar" height="225" :options="chartOptions" :series="series")
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
          colors: ['#e57373'],
          chart: {
            height: 250,
            type: 'bar',
            toolbar: {
              show: true,
              tools: {
                download: true,
                selection: false,
                zoom: false,
                zoomin: false,
                zoomout: false,
                pan: false,
                reset: false
              }
            },
          },
          plotOptions: {
            bar: {
              borderRadius: 3,
              columnWidth: '90%',
            }
          },
          dataLabels: {
            enabled: true
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
              show: false,
              rotate: -45
            },
            categories: [
              "Застелить кровать", "Сделать зарядку", "Помочь маме", "Убрать рабочий стол", "Позаниматься англ.яз", "Сделать ДЗ", "Почитать перед сном"
            ],
          },
          yaxis: {
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

