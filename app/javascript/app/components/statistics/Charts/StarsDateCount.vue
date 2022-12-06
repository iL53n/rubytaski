<template lang="pug">
  //.row.justify-around
  q-card.col.q-ma-md
    div(id="chart")
      div(class="toolbar")
        br
        q-btn-group(outline class="text-primary bg-deep-purple-1 outline")
          q-btn(id="one_month"  @click="updateData('one_month')"  size="sm" :class="{select: selection==='one_month'}") 1M
          q-btn(id="six_months" @click="updateData('six_months')" size="sm" :class="{select: selection==='six_months'}") 6M
          q-btn(id="one_year"   @click="updateData('one_year')"   size="sm" :class="{select: selection==='one_year'}") 1Y
          q-btn(id="ytd"        @click="updateData('ytd')"        size="sm" :class="{select: selection==='ytd'}") YTD
          q-btn(id="all"        @click="updateData('all')"        size="sm" :class="{select: selection==='all'}") ALL

    div(id="chart-timeline")
      apexchart(type="area" height="350" ref="chart" :options="chartOptions" :series="series")
</template>

<script>
  export default {
    data () {
      return {
        series: [],
        chartOptions: {
          chart: {
            id: 'area-datetime',
            type: 'area',
            height: 350,
            zoom: {
              autoScaleYaxis: false
            },
            // animationEnd: window.dispatchEvent(new Event('resize'))
          },
          annotations: {},
          dataLabels: {
            enabled: false
          },
          markers: {
            size: 0,
            style: 'hollow',
          },
          xaxis: {
            type: 'datetime'
          },
          tooltip: {
            x: {
              format: 'dd MMM yyyy'
            }
          },
          stroke: {
            curve: 'smooth'
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
    mounted() {
      // window.dispatchEvent(new Event('resize'))
    },
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
  background-color: rgb(101, 68, 211);
  font-weight: bold;
}
</style>

