<template lang="pug">
  q-card.col.q-ma-md
    div(id="chart")
      div(class="toolbar")
        br
        .q-pa-sm.text-body1.text-blue-grey-8.float-left Stars by date
        q-btn-group(outline class="text-blue-grey-8 bg-blue-grey-1 outline")
          q-btn(id="one_month"  @click="updateData('one_month')"  size="sm" :class="{select: selection==='one_month'}") 1M
          q-btn(id="six_months" @click="updateData('six_months')" size="sm" :class="{select: selection==='six_months'}") 6M
          q-btn(id="one_year"   @click="updateData('one_year')"   size="sm" :class="{select: selection==='one_year'}") 1Y
          q-btn(id="ytd"        @click="updateData('ytd')"        size="sm" :class="{select: selection==='ytd'}") YTD
          q-btn(id="all"        @click="updateData('all')"        size="sm" :class="{select: selection==='all'}") ALL

    div(id="chart-timeline")
      apexchart(type="area" height="250" ref="chart" :options="chartOptions" :series="series")
</template>

<script>
  export default {
    data () {
      return {
        series: [],
        chartOptions: {
          colors: ['#40a0fc'],
          chart: {
            id: 'area-datetime',
            type: 'area',
            height: 250,
            zoom: { autoScaleYaxis: true },
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
          annotations: {},
          dataLabels: { enabled: false },
          markers: {
            size: 0,
            style: 'hollow',
          },
          yaxis: {
            min: 0,
            tickAmount: 3
          },
          xaxis: {
            type: 'datetime',
            tickAmount: 6,
            // min: // min date in the init view
          },
          tooltip: { x: { format: 'dd MMM yyyy' } },
          stroke: { curve: 'smooth' },
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
        selection: 'all',
        today: new Date(),
      }
    },
    computed: {
      one_month_ago() {
        return new Date(this.today.getFullYear(), this.today.getMonth() - 1, this.today.getDate())
      },
      one_year_ago() {
        return new Date(this.today.getFullYear() - 1, this.today.getMonth(), this.today.getDate())
      },
      start_of_year() {
        return new Date(this.today.getFullYear(), 0, 1)
      }
    },
    created() {
      this.getStatistics()
    },
    mounted() {},
    methods: {
      getStatistics() {
        this.$backend.statistics.index({ scopes: 'stars_date_count' })
            .then((response) => {
              this.series.push({
                name: 'Stars',
                data: response.data.stat.stars_date_count
              })
            })
            .catch(()   => this.error = true)
            .finally(() => this.loading = false)
      },
      updateData(timeline) {
        this.selection = timeline

        switch (timeline) {
          case 'one_month':
            this.$refs.chart.zoomX(
                this.one_month_ago.getTime(),
                this.today.getTime()
            )
            break
          case 'six_months':
            this.$refs.chart.zoomX(
                new Date(
                    this.today.getFullYear(), this.today.getMonth() - 6, this.today.getDate()
                ).getTime(),
                this.today.getTime()
            )
            break
          case 'one_year':
            this.$refs.chart.zoomX(
                this.one_year_ago.getTime(),
                this.today.getTime()
            )
            break
          case 'ytd':
            this.$refs.chart.zoomX(
                this.start_of_year.getTime(),
                this.today.getTime()
            )
            break
          case 'all':
            this.$refs.chart.zoomX()
            break
          default:
        }
      }
    }
  }
</script>

<style scoped>
.select {
  color: white;
  background-color: #6f8192;
  font-weight: bold;
}
</style>

