<template lang="pug">
  div(class="q-pa-md row justify-around")
    calendar-heatmap(
      :values="data"
      :vertical="true"
      :tooltip-unit="$t('heatmap.unit')"
      :locale="$t('heatmap.locale')"
      :end-date="last_months_day"
      :range-color="['#eceef0','#9ceaaa','#3ec563','#2ca24d','#1b6e36']"
      )
</template>

<script>
  export default {
    // props: ['values'],
    data () {
      return {
        last_months_day: {},
        current_date: new Date()
      }
    },
    computed: {
      data: {
        get() {
          return this.$store.state.statistics.heatmap
        },
        set(value) {
          this.$store.commit('updateHeatmapStatistics', value)
        }
      }
    },
    created() {
      this.getStatistics(),
      // TODO: computer better?
      this.getLastMonthsDay()
    },
    methods: {
      getStatistics() {
        this.$backend.statistics.index({ scopes: 'heatmap' })
          .then((response) => {
            this.data = response.data.stat.heatmap
          })
          .catch(()   => this.error = true)
          .finally(() => this.loading = false)
      },
      getLastMonthsDay() {
        this.last_months_day = new Date(this.current_date.getFullYear(), this.current_date.getMonth() + 1, 0);
      }  
    }
  }
</script>

<style scoped></style>