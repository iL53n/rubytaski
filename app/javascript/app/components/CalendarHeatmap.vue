<template lang="pug">
  div(class="q-pa-md row justify-around")
    q-card(class="my-card")
      q-card-section
        //- https://www.color-hex.com/color/6544d3
        calendar-heatmap(
          :values="data"
          tooltip-unit="stars"
          :end-date="last_months_day"
          :range-color="['#f7f5fc','#e0d9f6','#b2a1e9','#8369db','#5036a8']"
          )
</template>

<script>
  export default {
    // props: ['values'],
    data () {
      return {
        data: [],
        last_months_day: {},
        current_date: new Date()
      }
    },
    created() {
      this.getStatistics(),
      this.getLastMonthsDay()
    },
    methods: {
      getStatistics() {
        this.$backend.statistics.index()
          .then((response) => {
            this.data = response.data
            this.getTasks()
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

<style scoped>
  .my-card {
    width: 80%;
    max-width: 1135px;
    /* height: 10%; */
    /* max-height: 100px */
  }
</style>